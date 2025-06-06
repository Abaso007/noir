require "../../func_spec.cr"

extected_endpoints = [
  Endpoint.new("/Open/Callback/{appId}", "GET", [
    Param.new("appId", "", "path"),
  ]),
  Endpoint.new("/data/default", "GET"),
]

FunctionalTester.new("fixtures/csharp/aspnet_mvc/", {
  :techs     => 1,
  :endpoints => extected_endpoints.size,
}, extected_endpoints).perform_tests
