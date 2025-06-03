require "../../func_spec.cr"

extected_endpoints = [
  # Basic routes
  Endpoint.new("/", "GET", [
    Param.new("name", "", "query"),
    Param.new("x-api-key", "", "header"),
  ]),
  # Endpoint.new("/register", "POST", [
  #   Param.new("username", "", "json"),
  #   Param.new("email", "", "json"),
  #   Param.new("password", "", "json"),
  #   Param.new("client-id", "", "header"),
  # ]),
  # Route with URL parameters
  #   Endpoint.new("/users/:userId", "GET", [
  #     Param.new("userId", "", "path"),
  #     Param.new("fields", "", "query"),
  #   ]),
  #   # Routes with different HTTP methods
  #   Endpoint.new("/products", "GET", [
  #     Param.new("category", "", "query"),
  #     Param.new("limit", "", "query"),
  #   ]),
  #   Endpoint.new("/products", "POST", [
  #     Param.new("name", "", "json"),
  #     Param.new("price", "", "json"),
  #     Param.new("category", "", "json"),
  #     Param.new("store-id", "", "header"),
  #   ]),
  #   # Route with cookies
  #   Endpoint.new("/dashboard", "GET", [
  #     Param.new("view", "", "query"),
  #     Param.new("sessionId", "", "cookie"),
  #   ]),
  #   # Routes with prefixes - API v1
  #   Endpoint.new("/api/v1/status", "GET", [
  #     Param.new("format", "", "query"),
  #     Param.new("x-status-key", "", "header"),
  #   ]),
  #   Endpoint.new("/api/v1/config", "PUT", [
  #     Param.new("theme", "", "json"),
  #     Param.new("notifications", "", "json"),
  #     Param.new("configToken", "", "cookie"),
  #   ]),
  #   # Admin routes
  #   Endpoint.new("/admin/stats", "GET", [
  #     Param.new("period", "", "query"),
  #     Param.new("admin-token", "", "header"),
  #   ]),
  #   Endpoint.new("/admin/users/create", "POST", [
  #     Param.new("username", "", "json"),
  #     Param.new("role", "", "json"),
  #     Param.new("permissions", "", "json"),
  #     Param.new("masterKey", "", "cookie"),
  #   ]),
  #   Endpoint.new("/admin/system/logs", "GET", [
  #     Param.new("date", "", "query"),
  #     Param.new("level", "", "query"),
  #   ]),
  #   # Payment routes
  #   Endpoint.new("/payments/process/:methodId", "POST", [
  #     Param.new("methodId", "", "path"),
  #     Param.new("amount", "", "json"),
  #     Param.new("currency", "", "json"),
  #     Param.new("description", "", "json"),
  #     Param.new("payment-key", "", "header"),
  #   ]),
  #   Endpoint.new("/payments/transactions", "GET", [
  #     Param.new("startDate", "", "query"),
  #     Param.new("endDate", "", "query"),
  #     Param.new("merchant-id", "", "header"),
  #   ]),
  # Content-type specific route
  Endpoint.new("/api/v1/upload", "POST"),
]

FunctionalTester.new("fixtures/javascript/fastify/", {
  :techs     => 1,
  :endpoints => extected_endpoints.size,
}, extected_endpoints).perform_tests
