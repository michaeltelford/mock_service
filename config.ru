require 'rack'
require 'rack/json_parser'
require 'simple_router'
require_relative 'helpers'
require_relative 'app'

use Rack::JSONParser

run App.new
