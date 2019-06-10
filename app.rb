class App
  include SimpleRouter::DSL
  extend Helpers

  CONTENT_TYPE_JSON  = { 'Content-Type' => 'application/json' }
  CONTENT_TYPE_HTML  = { 'Content-Type' => 'text/html' }
  CONTENT_TYPE_PLAIN = { 'Content-Type' => 'text/plain' }

  get '/healthcheck' do
    respond 204
  end

  get '/auth' do
    respond 200, headers: CONTENT_TYPE_JSON, body: { 'api_key' => 123 }
  end

  post '/auth' do
    respond 201, headers: CONTENT_TYPE_JSON, body: { 'logged_in' => true }
  end

  get '/profile' do
    respond 200, headers: CONTENT_TYPE_JSON, body: file('profile.json')
  end

  get '/greet' do
    respond 200, headers: CONTENT_TYPE_HTML, body: file('greet.html')
  end

  def call(env)
    request = Rack::Request.new(env)

    verb = request.request_method.downcase.to_sym
    path = Rack::Utils.unescape(request.path_info)

    route = self.class.routes.match(verb, path)
    if route.nil?
      [404, CONTENT_TYPE_PLAIN, ['Not found']]
    else
      route.action.call(*route.values.push(request.params))
    end
  end
end
