# Mock Service

Mock API responses using ruby, rack and docker (compose). Helpful for development and debugging.

## Prerequisites

- `docker`
- `ruby` (if running locally)

## How It Works

Since this app is just a plain `rack` application, the [rack interface](https://rack.github.io) is your guide to using it; In a nutshell a rack app must return an array of status, headers and body which can be something as simple as `[200, {}, ['Hello world.']]`. That's it.

Edit the `app.rb` file and add a handler which will return the response you give it. Clients can then query the endpoint and receive the mock response. Any code changes are automatically reloaded so you don't need to restart the service.

See the `docker-compose.yml` file for an example of how to slot mock service into your development workflow using docker-compose.

## Mocking Responses

A zero dependency, lightweight [`simple_router`](https://github.com/mynyml/simple_router) is used, allowing the following:

```ruby
post '/auth/:id' do |id|
  respond 201, body: { 'logged_in' => true, 'user_id' => id.to_i }
end
```

The helper method `respond(status, type: :json, headers: {}, body: [])` can be used to send responses, saving some boiler plate code. It does some helpful things like automatically setting the content type and length headers where necessary.

You can load a file (containing HTML, JSON etc.) into a string using the helper method `file(name)`, again saving some boiler plate. Files should be placed in the `fixtures` directory.

### JSON

The gem [`rack-jsonparser`](https://github.com/michaeltelford/rack_jsonparser) provides the JSON parsing middleware. This roughly means that...

A response body consisting of a ruby `Hash` will automatically be converted into a JSON string as long as the response `Content-Type` header is correctly set to `application/json`. The `respond` helper method will do this for you by default.

Alternatively, a `String` of JSON can be provided. It's up to you to ensure the JSON is valid.

## Examples

See `app.rb` for already built examples of endpoints returning different mock responses. Edit the file as you see fit.

## Usage

Run `bundle exec rake help` to see the available commands for running the mock server.
