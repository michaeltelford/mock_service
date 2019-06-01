require 'rack'
require 'rack/json_parser'
require_relative 'helpers'

CONTENT_TYPE_JSON = { 'Content-Type' => 'application/json' }
CONTENT_TYPE_HTML = { 'Content-Type' => 'text/html' }

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

greet = proc do |env|
  respond 200, headers: CONTENT_TYPE_HTML, body: file('greet.html')
end

app = Rack::Builder.new do
  use Rack::JSONParser

  # Map an endpoint to a service handler.
  map('/healthcheck') { run healthcheck }
  map('/auth') { run auth }
  map('/profile') { run profile }
  map('/greet') { run greet }
end

run app
