+++
title = "지원되는 언어 및 프레임워크"
description = "각각에 대한 기능 호환성을 포함하여 Noir가 지원하는 프로그래밍 언어와 프레임워크에 대한 자세한 개요입니다."
weight = 1
sort_by = "weight"

[extra]
+++

Noir는 엔드포인트와 해당 명세를 식별하여 코드베이스를 분석하고 이해하도록 설계된 도구입니다. 이 섹션은 Noir가 지원하는 프로그래밍 언어의 포괄적인 목록을 제공합니다. 각 언어에 대해 이 페이지는 프레임워크 열과 다음 필드를 포함한 단일 표를 보여줍니다: endpoint, method, query, path, body, header, cookie, static_path, websocket.

## C#

| Framework | endpoint | method | query | path | body | header | cookie | static_path | websocket |
|-----------|----------|--------|-------|------|------|--------|--------|-------------|-----------|
| ASP.NET MVC | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |

## Crystal

| Framework | endpoint | method | query | path | body | header | cookie | static_path | websocket |
|-----------|----------|--------|-------|------|------|--------|--------|-------------|-----------|
| Amber | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Grip | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ |
| Kemal | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ |
| Lucky | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ |
| Marten | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ |

## Elixir

| Framework | endpoint | method | query | path | body | header | cookie | static_path | websocket |
|-----------|----------|--------|-------|------|------|--------|--------|-------------|-----------|
| Phoenix | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ✅ |

## Go

| Framework | endpoint | method | query | path | body | header | cookie | static_path | websocket |
|-----------|----------|--------|-------|------|------|--------|--------|-------------|-----------|
| Beego | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |
| Chi | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ |
| Echo | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ |
| Fiber | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ |
| Gin | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |
| fasthttp | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |
| go-zero | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ |

## Java

| Framework | endpoint | method | query | path | body | header | cookie | static_path | websocket |
|-----------|----------|--------|-------|------|------|--------|--------|-------------|-----------|
| Armeria | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| JSP | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ | ✅ | ❌ |
| Spring | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ |

## JavaScript

| Framework | endpoint | method | query | path | body | header | cookie | static_path | websocket |
|-----------|----------|--------|-------|------|------|--------|--------|-------------|-----------|
| Express | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |
| Fastify | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |
| Koa | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ |
| NestJS | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |
| Restify | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |

## Kotlin

| Framework | endpoint | method | query | path | body | header | cookie | static_path | websocket |
|-----------|----------|--------|-------|------|------|--------|--------|-------------|-----------|
| Ktor | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ |
| Spring | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |

## PHP

| Framework | endpoint | method | query | path | body | header | cookie | static_path | websocket |
|-----------|----------|--------|-------|------|------|--------|--------|-------------|-----------|
| Pure | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ | ❌ |
| Symfony | ✅ | ✅ | ❌ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |

## Python

| Framework | endpoint | method | query | path | body | header | cookie | static_path | websocket |
|-----------|----------|--------|-------|------|------|--------|--------|-------------|-----------|
| Django | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ |
| FastAPI | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |
| Flask | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |
| Sanic | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ |
| Tornado | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ✅ |

## Ruby

| Framework | endpoint | method | query | path | body | header | cookie | static_path | websocket |
|-----------|----------|--------|-------|------|------|--------|--------|-------------|-----------|
| Hanami | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Rails | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ |
| Sinatra | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ |

## Rust

| Framework | endpoint | method | query | path | body | header | cookie | static_path | websocket |
|-----------|----------|--------|-------|------|------|--------|--------|-------------|-----------|
| Actix Web | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Axum | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ |
| Gotham | ✅ | ✅ | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Loco | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| RWF | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Rocket | ✅ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Tide | ✅ | ✅ | ❌ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
| Warp | ✅ | ✅ | ❌ | ✅ | ❌ | ❌ | ❌ | ❌ | ❌ |
