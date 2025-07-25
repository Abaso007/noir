require "../../../models/analyzer"

module Analyzer::Elixir
  class Phoenix < Analyzer
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
                  if File.exists?(path) && File.extname(path) == ".ex"
                    File.open(path, "r", encoding: "utf-8", invalid: :skip) do |file|
                      file.each_line.with_index do |line, index|
                        endpoints = line_to_endpoint(line)
                        endpoints.each do |endpoint|
                          if endpoint.method != ""
                            details = Details.new(PathInfo.new(path, index + 1))
                            endpoint.details = details
                            @result << endpoint
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
        logger.debug e
      end

      @result
    end

    def line_to_endpoint(line : String) : Array(Endpoint)
      endpoints = Array(Endpoint).new

      line.scan(/get\s+['"](.+?)['"]\s*,\s*(.+?)\s*/) do |match|
        endpoints << Endpoint.new("#{match[1]}", "GET")
      end

      line.scan(/post\s+['"](.+?)['"]\s*,\s*(.+?)\s*/) do |match|
        endpoints << Endpoint.new("#{match[1]}", "POST")
      end

      line.scan(/patch\s+['"](.+?)['"]\s*,\s*(.+?)\s*/) do |match|
        endpoints << Endpoint.new("#{match[1]}", "PATCH")
      end

      line.scan(/put\s+['"](.+?)['"]\s*,\s*(.+?)\s*/) do |match|
        endpoints << Endpoint.new("#{match[1]}", "PUT")
      end

      line.scan(/delete\s+['"](.+?)['"]\s*,\s*(.+?)\s*/) do |match|
        endpoints << Endpoint.new("#{match[1]}", "DELETE")
      end

      line.scan(/socket\s+['"](.+?)['"]\s*,\s*(.+?)\s*/) do |match|
        tmp = Endpoint.new("#{match[1]}", "GET")
        tmp.protocol = "ws"
        endpoints << tmp
      end

      endpoints
    end
  end
end
