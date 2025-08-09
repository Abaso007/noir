+++
title = "Supported Specifications"
description = "This page provides a detailed overview of the API and data specifications that Noir supports, including OpenAPI (Swagger), RAML, HAR, and GraphQL. See the compatibility table for more information."
weight = 2
sort_by = "weight"

[extra]
+++

In addition to analyzing source code directly, Noir can also parse various API and data specification formats. This allows you to use Noir to analyze existing API documentation, captured network traffic, and more.

This section provides a compatibility table for the different specifications that Noir supports.

| Specification | Format | URL | Method | Param | Header | WS |
|---|---|---|---|---|---|---|
| OAS 2.0 (Swagger 2.0) | JSON | ✅ | ✅ | ✅ | ✅ | ❌ |
| OAS 2.0 (Swagger 2.0) | YAML | ✅ | ✅ | ✅ | ✅ | ❌ |
| OAS 3.0 | JSON | ✅ | ✅ | ✅ | ✅ | ❌ |
| OAS 3.0 | YAML | ✅ | ✅ | ✅ | ✅ | ❌ |
| RAML | YAML | ✅ | ✅ | ✅ | ✅ | ❌ |
| HAR | JSON | ✅ | ✅ | ✅ | ✅ | ❌ |
| GraphQL SDL (.graphql) | GraphQL | ✅ | ✅ | ✅ | ✅ | ❌ |
