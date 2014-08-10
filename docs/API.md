
## Creating Overheards
Route: POST /overheards
Headers: `Content-Type: application/json`
Body: `{ "overheard": { "body": "Your fancy quote" } }`


### Examples:
#### CURL
From your terminal:

```bash
curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X \
POST -d '{"overheard":{"body":"y hello"}}' http://localhost:9292/overheards
```

Approximate response:

```json
{ "overheard": { "id": 1, "body": "y hello", "created_at": "2014-08-09T16:30:16-07:00" } }
```

If you do not include a valid overheard; the server will respond with a status
code of 400 as well as provide a json representation of an overheard with an
additional errors hash:

```bash
curl -i -H "Accept: application/json" -H "Content-Type: application/json" -X \
POST -d '{"overheard":{ "bardy": "lol that's not the right key!" }}' \
http://localhost:9292/overheards
```

Approximate response:

```json
{ "overheard": { "errors": { "body": ["Body must not be blank"] }, "id": null, "body": null, "created_at": null } }
```

#### Ruby
This example uses the built in ruby HTTP methods. Using
[excon](https://github.com/excon/excon) or
[httparty](https://github.com/jnunemaker/httparty) is much easier.

Within IRB:

```ruby
require "net/http"
require "uri"

uri = URI.parse("http://localhost:9292/overheards")

http_client = Net::HTTP.new(uri.host, uri.port)
new_overheard_request = Net::HTTP::Post.new(uri.request_uri)
new_overheard_request["Content-Type"] = "application/json"
new_overheard_request["Accept"] = "application/json"

response = http_client.request(new_overheard_request)

p response.code # => "200"
p response.body.class # => String
p response.body # => "{ 'overheard': { 'id': 1, 'body': 'y hello' } }"
```
