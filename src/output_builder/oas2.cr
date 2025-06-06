require "../models/output_builder"
require "../models/endpoint"
require "uri"

class OutputBuilderOas2 < OutputBuilder
  def print(endpoints : Array(Endpoint))
    paths = {} of String => Hash(String, Hash(String, Array(Hash(String, String)) | Hash(String, Hash(String, String))))
    endpoints.each do |endpoint|
      parameters = [] of Hash(String, String)
      endpoint.params.each do |param|
        in_str = "query"
        if param.param_type == "json"
          in_str = "form"
        elsif param.param_type == "form"
          in_str = "formData"
        elsif param.param_type == "header"
          in_str = "header"
        end

        parameters << {
          "name" => param.name,
          "in"   => in_str,
        }
      end

      path = {
        endpoint.method.downcase.to_s => {
          "responses" => {
            "200" => {
              "description" => "Successful response",
            },
          },
          "parameters" => parameters,
        },
      }
      uri = URI.parse(endpoint.url)
      paths[uri.path] = path
    end

    oas2 = {
      "swagger" => "2.0",
      "info"    => {
        "title"   => "Generated by Noir",
        "version" => "",
      },
      "basePath" => "",
      "paths"    => paths,
    }

    ob_puts oas2.to_json
  end
end
