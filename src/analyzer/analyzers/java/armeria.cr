require "../../../models/analyzer"

module Analyzer::Java
  class Armeria < Analyzer
    REGEX_SERVER_CODE_BLOCK = /Server\s*\.builder\(\s*\)\s*\.[^;]*?build\(\)\s*\./
    REGEX_SERVICE_CODE      = /\.service(If|Under|)?\([^;]+?\)/
    REGEX_ROUTE_CODE        = /\.route\(\)\s*\.\s*(\w+)\s*\(([^\.]*)\)\./

    def analyze
      # Source Analysis
      channel = Channel(String).new

      begin
        populate_channel_with_files(channel)

        WaitGroup.wait do |wg|
          @options["concurrency"].to_s.to_i.times do
            wg.spawn do
              loop do
                begin
                  path = channel.receive?
                  break if path.nil?
                  next if File.directory?(path)

                  if File.exists?(path) && (path.ends_with?(".java") || path.ends_with?(".kt"))
                    details = Details.new(PathInfo.new(path))

                    content = File.read(path, encoding: "utf-8", invalid: :skip)
                    content.scan(REGEX_SERVER_CODE_BLOCK) do |server_codeblock_match|
                      server_codeblock = server_codeblock_match[0]

                      server_codeblock.scan(REGEX_SERVICE_CODE) do |service_code_match|
                        next if service_code_match.size != 2
                        endpoint_param_index = 0
                        if service_code_match[1] == "If"
                          endpoint_param_index = 1
                        end

                        service_code = service_code_match[0]
                        parameter_code = service_code.split("(")[1]
                        split_params = parameter_code.split(",")
                        next if split_params.size <= endpoint_param_index
                        endpoint = split_params[endpoint_param_index].strip

                        endpoint = endpoint[1..-2]
                        @result << Endpoint.new("#{endpoint}", "GET", details)
                      end

                      server_codeblock.scan(REGEX_ROUTE_CODE) do |route_code_match|
                        next if route_code_match.size != 3
                        method = route_code_match[1].upcase
                        if method == "PATH"
                          method = "GET"
                        end

                        next if !["GET", "POST", "DELETE", "PUT", "PATCH", "HEAD", "OPTIONS"].includes?(method)

                        endpoint = route_code_match[2].split(")")[0].strip
                        next if endpoint[0] != endpoint[-1]
                        next if endpoint[0] != '"'

                        endpoint = endpoint[1..-2]
                        @result << Endpoint.new("#{endpoint}", method, details)
                      end
                    end
                  end
                rescue e : File::NotFoundError
                  logger.debug "File not found: #{path}"
                end
              end
            end
          end
        end
      rescue e
        logger.debug e
      end
      Fiber.yield

      @result
    end
  end
end
