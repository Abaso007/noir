require "../../func_spec.cr"

extected_endpoints = [
  Endpoint.new("/", "GET"),
  Endpoint.new("/secret.html", "GET"),
  Endpoint.new("/api/me", "GET", [
    Param.new("q", "", "query"),
    Param.new("query", "", "query"),
    Param.new("filter", "", "query"),
    Param.new("X-Forwarded-For", "", "header"),
  ]),
  Endpoint.new("/api/sign_ins", "POST", [Param.new("users", "", "json")]),
  Endpoint.new("/api/sign_ups", "POST", [
    Param.new("name1", "", "cookie"),
    Param.new("name2", "", "cookie"),
    Param.new("name3", "", "cookie"),
  ]),
]

FunctionalTester.new("fixtures/crystal/lucky/", {
  :techs     => 1,
  :endpoints => extected_endpoints.size,
}, extected_endpoints).perform_tests
