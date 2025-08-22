require "../../../models/analyzer"

module Analyzer::Rust
  class Warp < Analyzer
    def analyze
      # Pattern for GET endpoints with warp::get()
      get_pattern = /warp::get\(\)/
      post_pattern = /warp::post\(\)/
      path_pattern = /warp::path\("([^"]+)"\)/
      path_end_pattern = /warp::path::end\(\)/
      path_param_pattern = /warp::path::param/
      
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

                  if File.exists?(path) && File.extname(path) == ".rs"
                    File.open(path, "r", encoding: "utf-8", invalid: :skip) do |file|
                      content = file.gets_to_end
                      
                      # Simple approach: split by let statements and analyze each
                      statements = content.split(/(?=let\s+\w+\s*=)/)
                      statements.each do |statement|
                        if statement.includes?("warp::") && (statement.includes?("get()") || statement.includes?("post()") || statement.includes?("put()") || statement.includes?("delete()"))
                          endpoint = parse_warp_statement(statement, path)
                          if endpoint
                            result << endpoint
                          end
                        end
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
      end

      result
    end

    private def parse_warp_statement(statement : String, file_path : String) : Endpoint?
      # Extract HTTP method
      method = "GET"
      if statement.includes?("warp::get()")
        method = "GET"
      elsif statement.includes?("warp::post()")
        method = "POST"
      elsif statement.includes?("warp::put()")
        method = "PUT"
      elsif statement.includes?("warp::delete()")
        method = "DELETE"
      end
      
      # Build path
      path_parts = [] of String
      params = [] of Param
      
      # Check for root path (path::end without explicit path)
      if statement.includes?("warp::path::end()") && !statement.includes?("warp::path(\"")
        details = Details.new(PathInfo.new(file_path, 1))
        return Endpoint.new("/", method, params, details)
      end
      
      # Extract explicit path segments
      statement.scan(/warp::path\("([^"]+)"\)/) do |match|
        if match.size > 1
          path_parts << match[1]
        end
      end
      
      # Count parameters and add them to both path and params array
      param_count = statement.scan(/warp::path::param/).size
      param_count.times do |i|
        param_name = "param"
        if param_count > 1
          param_name = "param#{i + 1}"
        end
        path_parts << ":#{param_name}"
        params << Param.new(param_name, "", "path")
      end
      
      if path_parts.empty?
        return nil
      end
      
      route_path = "/" + path_parts.join("/")
      
      details = Details.new(PathInfo.new(file_path, 1))
      Endpoint.new(route_path, method, params, details)
    rescue
      nil
    end
  end
end