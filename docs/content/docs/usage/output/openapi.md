---
title: Open API Spec
weight: 4
has_children: false
nav_order: 3
layout: page
---

The Open API Specification (OAS) defines a standard, language-agnostic interface to RESTful APIs. Noir can generate OAS 2.0 and 3.0 specifications for your endpoints.

```bash
# oas3
noir -b . -f oas3

# oas2
noir -b . -f oas2
```

```json
{
  "openapi": "3.0.0",
  "info": {
    "title": "Generated by Noir",
    "version": ""
  },
  "paths": {
    "/": {
      "get": {
        "responses": {
          "200": {
            "description": "Successful response"
          }
        },
        "parameters": [
          {
            "name": "x-api-key",
            "in": "header"
          }
        ]
      }
    },
    "/query": {
      "post": {
        "responses": {
          "200": {
            "description": "Successful response"
          }
        },
        "parameters": [
          {
            "name": "my_auth",
            "in": "query"
          },
          {
            "name": "query",
            "in": "formData"
          }
        ]
      }
    },
    "/token": {
      "get": {
        "responses": {
          "200": {
            "description": "Successful response"
          }
        },
        "parameters": [
          {
            "name": "client_id",
            "in": "formData"
          },
          {
            "name": "redirect_url",
            "in": "formData"
          },
          {
            "name": "grant_type",
            "in": "formData"
          }
        ]
      }
    },
    "/socket": {
      "get": {
        "responses": {
          "200": {
            "description": "Successful response"
          }
        },
        "parameters": []
      }
    },
    "/1.html": {
      "get": {
        "responses": {
          "200": {
            "description": "Successful response"
          }
        },
        "parameters": []
      }
    },
    "/2.html": {
      "get": {
        "responses": {
          "200": {
            "description": "Successful response"
          }
        },
        "parameters": []
      }
    }
  }
}
```