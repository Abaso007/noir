require "../func_spec.cr"

extected_endpoints = [
  Endpoint.new("/pets", "GET", [
    Param.new("query", "", "query"),
    Param.new("sort", "", "query"),
    Param.new("cookie", "", "cookie"),
  ]),
  Endpoint.new("/pets", "POST", [
    Param.new("name", "", "json"),
  ]),
  Endpoint.new("/pets/{petId}", "GET", [Param.new("petId", "", "path")]),
  Endpoint.new("/pets/{petId}", "PUT", [
    Param.new("petId", "", "path"),
    Param.new("breed", "", "json"),
    Param.new("name", "", "json"),
  ]),
]

FunctionalTester.new("fixtures/oas3/common/", {
  :techs     => 1,
  :endpoints => extected_endpoints.size,
}, extected_endpoints).test_all

FunctionalTester.new("fixtures/oas3/no_servers/", {
  :techs     => 1,
  :endpoints => 1,
}, nil).test_all

FunctionalTester.new("fixtures/oas3/multiple_docs/", {
  :techs     => 1,
  :endpoints => 2,
}, nil).test_all

FunctionalTester.new("fixtures/oas3/nil_cast/", {
  :techs     => 1,
  :endpoints => 0,
}, nil).test_all

FunctionalTester.new("fixtures/oas3/param_in_path/", {
  :techs     => 1,
  :endpoints => 4,
}, [
  Endpoint.new("/gems_yml", "GET", [
    Param.new("query", "", "query"),
    Param.new("sort", "", "query"),
    Param.new("cookie", "", "cookie"),
  ]),
  Endpoint.new("/gems_yml", "PUT", [
    Param.new("query", "", "query"),
    Param.new("sort", "", "query"),
    Param.new("cookie", "", "cookie"),
  ]),
  Endpoint.new("/gems_json", "GET", [
    Param.new("query", "", "query"),
    Param.new("sort", "", "query"),
    Param.new("cookie", "", "cookie"),
  ]),
  Endpoint.new("/gems_json", "POST", [
    Param.new("query", "", "query"),
    Param.new("sort", "", "query"),
    Param.new("cookie", "", "cookie"),
  ]),
]).test_all
