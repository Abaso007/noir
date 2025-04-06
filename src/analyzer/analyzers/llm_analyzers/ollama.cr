require "../../../utils/utils.cr"
require "../../../models/analyzer"
require "../../../llm/ollama"
require "../../../llm/prompt"

module Analyzer::AI
  class Ollama < Analyzer
    @llm_url : String
    @model : String
    @max_tokens : Int32

    def initialize(options : Hash(String, YAML::Any))
      super(options)
      @llm_url = options["ollama"].as_s
      @model = options["ollama_model"].as_s
      @max_tokens = LLM.get_max_tokens("ollama", @model)
    end

    def analyze
      ollama = LLM::Ollama.new(@llm_url, @model)
      target_paths = select_target_paths(ollama)

      if target_paths.empty?
        logger.warning "No files selected for Ollama analysis"
        return @result
      end

      # Use the bundling approach if we have a token limit
      logger.info "Ollama Analysis using model #{@model} (max tokens: #{@max_tokens})"

      if @max_tokens > 0
        analyze_with_bundling(target_paths, ollama)
      else
        # Fallback to individual file analysis if we can't determine token limits
        target_paths.each { |path| analyze_file(path, ollama) }
      end

      Fiber.yield
      @result
    end

    private def analyze_with_bundling(paths : Array(String), client : LLM::Ollama)
      files_to_bundle = [] of Tuple(String, String)
      paths.each do |path|
        next if File.directory?(path) || !File.exists?(path) || ignore_extensions.includes?(File.extname(path))
        relative_path = get_relative_path(base_path, path)
        content = File.read(path, encoding: "utf-8", invalid: :skip)
        files_to_bundle << {relative_path, content}
      end

      bundles = LLM.bundle_files(files_to_bundle, @max_tokens)
      channel = Channel(Tuple(String, Int32)).new

      bundles.each_with_index do |bundle, index|
        spawn do
          bundle_content, token_count = bundle
          logger.info "Processing bundle #{index + 1}/#{bundles.size} (#{token_count} tokens)"
          process_bundle(bundle_content, client)
          channel.send({bundle_content, token_count})
        end
      end

      bundles.size.times { channel.receive }
    end

    private def process_bundle(bundle_content : String, ollama : LLM::Ollama)
      prompt = "#{LLM::BUNDLE_ANALYZE_PROMPT}\n#{bundle_content}"
      response = ollama.request(prompt, LLM::ANALYZE_FORMAT)

      logger.debug "Bundle analysis response:"
      logger.debug_sub response

      begin
        response_json = JSON.parse(response.to_s)
        response_json["endpoints"].as_a.each do |ep|
          url = ep["url"].as_s
          method = ep["method"].as_s

          # Extract file path from the endpoint data if available
          # or use a default path
          path_info = if ep.as_h.has_key?("file") && !ep["file"].as_s.empty?
                        PathInfo.new(ep["file"].as_s)
                      else
                        PathInfo.new("#{base_path}/ollama_detected")
                      end

          params = ep["params"].as_a.map do |param|
            p = param.as_h
            name = p["name"].as_s
            param_type = if p.has_key?("param_type")
                           p["param_type"].as_s
                         elsif p.has_key?("type")
                           p["type"].as_s
                         else
                           ""
                         end
            value = p["value"]? ? p["value"].as_s : ""
            Param.new(name, value, param_type)
          end

          details = Details.new(path_info)
          @result << Endpoint.new(url, method, params, details)
        end
      rescue e : Exception
        logger.warning "Error parsing bundle response: #{e.message}"
      end
    end

    private def select_target_paths(ollama : LLM::Ollama) : Array(String)
      locator = CodeLocator.instance
      all_paths = locator.all("file_map")

      if all_paths.size > 10
        logger.debug_sub "Ollama::Analyzing filtered files"
        prompt = "#{LLM::FILTER_PROMPT}\n" +
                 all_paths.map { |p| "- #{File.expand_path(p)}" }.join("\n")
        filter_response = ollama.request(prompt, LLM::FILTER_FORMAT)
        logger.debug_sub filter_response

        begin
          filtered = JSON.parse(filter_response.to_s)
          return filtered["files"].as_a.map(&.as_s)
        rescue e : Exception
          logger.debug "Error parsing filter response: #{e.message}"
          # fallback: analyze all files
          return Dir.glob("#{base_path}/**/*").reject { |p| File.directory?(p) || ignore_extensions.includes?(File.extname(p)) }
        end
      else
        logger.debug_sub "Ollama::Analyzing all files"
      end

      Dir.glob("#{base_path}/**/*").reject { |p| File.directory?(p) || ignore_extensions.includes?(File.extname(p)) }
    end

    private def analyze_file(path : String, ollama : LLM::Ollama)
      return if File.directory?(path)
      relative_path = get_relative_path(base_path, path)

      if File.exists?(path) && !ignore_extensions.includes?(File.extname(path))
        File.open(path, "r", encoding: "utf-8", invalid: :skip) do |file|
          content = file.gets_to_end
          process_content(content, relative_path, path, ollama)
        end
      end
    rescue ex : Exception
      logger.debug "Error processing file: #{path}"
      logger.debug "Error: #{ex.message}"
    end

    private def process_content(content : String, relative_path : String, path : String, ollama : LLM::Ollama)
      prompt = "#{LLM::ANALYZE_PROMPT}\n#{content}"
      response = ollama.request(prompt, LLM::ANALYZE_FORMAT)
      logger.debug "Ollama response (#{relative_path}):"
      logger.debug_sub response

      begin
        response_json = JSON.parse(response.to_s)
        endpoints = response_json["endpoints"].as_a
        return if endpoints.empty?

        endpoints.each do |endpoint|
          url = endpoint["url"].as_s
          method = endpoint["method"].as_s
          params = endpoint["params"].as_a.map do |param|
            Param.new(
              param["name"].as_s,
              param["value"].as_s,
              param["param_type"].as_s
            )
          end
          details = Details.new(PathInfo.new(path))
          @result << Endpoint.new(url, method, params, details)
        end
      rescue e : Exception
        logger.debug "Error parsing response for file: #{path}"
        logger.debug "Error: #{e.message}"
      end
    end

    def ignore_extensions
      [".css", ".xml", ".json", ".yml", ".yaml", ".md", ".jpg", ".jpeg", ".png", ".gif", ".svg", ".ico",
       ".eot", ".ttf", ".woff", ".woff2", ".otf", ".mp3", ".mp4", ".avi", ".mov", ".webm", ".zip", ".tar",
       ".gz", ".7z", ".rar", ".pdf", ".doc", ".docx", ".xls", ".xlsx", ".ppt", ".pptx", ".txt", ".csv",
       ".log", ".sql", ".bak", ".swp", ".jar"]
    end
  end
end
