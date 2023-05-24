# Noir
Discover all API and web page in the source code

> Developing now.. 🚧

## Key Features
- Automatically identify language and framework from source code.
- Find API endpoints and web pages through code analysis.
- Load results quickly through interactions with proxy tools such as ZAP, Burpsuite, Caido and More Proxy tools.
- It is possible to interact with other tools by providing structured data such as JSON and HAR for the results. (pipeline)

## Support
### Lanauge and Framework
|        |         | Auto-Detect | URL | Param | Header |
|--------|---------|-------------|-----|-------|--------|
| Go     | Echo    |      ✅     |  X  | X     | X      |
| Python | Django  |      ✅     |  X  | X     | X      |
| Ruby   | Rails   |      ✅     |  X  | X     | X      |
| Ruby   | Sinatra |      ✅     |  X  | X     | X      |
| Php    |         |      ✅     |  X  | X     | X      |
| Java   | Spring  |      ✅     |  X  | X     | X      |
| Java   | Jsp     |      ✅     |  X  | X     | X      |

### Output Format
- Plain
- JSON
- HAR
- CURL

## For Developers
### Set DevEnv
```bash
# If you've forked this repository, clone to https://github.com/<YOU>/noir
git clone https://github.com/hahwul/noir
cd noir
shards install
```

### Unit Test
```bash
crystal spec -v
```