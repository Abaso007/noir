require "../../func_spec.cr"

extected_endpoints = [
  # From UserController annotations
  Endpoint.new("/api/users", "GET", [
    Param.new("page", "", "query"),
    Param.new("limit", "", "query"),
    Param.new("search", "", "query"),
  ]),
  Endpoint.new("/api/users/{id}", "GET", [
    Param.new("id", "", "path"),
  ]),
  Endpoint.new("/api/users", "POST", [
    Param.new("name", "", "form"),
    Param.new("email", "", "form"),
  ]),
  Endpoint.new("/api/users/{id}", "PUT", [
    Param.new("id", "", "path"),
  ]),
  Endpoint.new("/api/users/{id}", "DELETE", [
    Param.new("id", "", "path"),
  ]),
  # From ProductController attributes
  Endpoint.new("/api/products", "GET"),
  Endpoint.new("/api/products/{slug}", "GET", [
    Param.new("slug", "", "path"),
  ]),
  Endpoint.new("/api/products", "POST", [
    Param.new("name", "", "form"),
    Param.new("price", "", "form"),
    Param.new("category", "", "query"),
  ]),
  Endpoint.new("/api/products/{slug}", "PATCH", [
    Param.new("slug", "", "path"),
  ]),
  # From routes.yaml
  Endpoint.new("/api/health", "GET"),
  Endpoint.new("/api/docs", "GET"),
  Endpoint.new("/api/categories", "GET"),
  Endpoint.new("/api/categories", "POST"),
  Endpoint.new("/api/categories/{id}", "GET", [
    Param.new("id", "", "path"),
  ]),
  Endpoint.new("/api/categories/{id}", "PUT", [
    Param.new("id", "", "path"),
  ]),
  Endpoint.new("/api/categories/{id}", "DELETE", [
    Param.new("id", "", "path"),
  ]),
  Endpoint.new("/api/search", "GET"),
  Endpoint.new("/webhooks/{provider}", "POST", [
    Param.new("provider", "", "path"),
  ]),
  Endpoint.new("/src/Controller/UserController.php", "GET"),
  Endpoint.new("/src/Controller/ProductController.php", "GET"),
]

FunctionalTester.new("fixtures/php/symfony/", {
  :techs     => 2,  # Both php_symfony and php_pure are detected
  :endpoints => 20, # Updated to include all methods from UserController (was 17, now 20)
}, extected_endpoints).perform_tests
