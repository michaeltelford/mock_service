require 'rack'
require 'rack/json_parser'
require_relative 'helpers'

CONTENT_TYPE_JSON = { 'Content-Type' => 'application/json' }

# Define any required service handlers below...

healthcheck = proc do |env|
  respond 204
end

auth = proc do |env|
  respond 200, headers: CONTENT_TYPE_JSON, body: {
    'api_key' => 123
  }
end

profile = proc do |env|
  respond 200, headers: CONTENT_TYPE_JSON, body: file('profile.json')
end

# Map an endpoint to a service handler.
app = Rack::Builder.new do
  use Rack::JSONParser, transform_request: true, transform_response: true

  map('/healthcheck') { run healthcheck }
  map('/auth') { run auth }
  map('/profile') { run profile }
end

run app
