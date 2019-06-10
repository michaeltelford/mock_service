class App
  include SimpleRouter::DSL
  extend Helpers

  get '/healthcheck' do
    respond 204
  end

  get '/auth' do
    respond 200, body: { 'api_key' => 123 }
  end

  post '/auth/:id' do |id|
    respond 201, body: { 'logged_in' => true, 'user_id' => id.to_i }
  end

  get '/profile' do
    respond 200, body: file('profile.json')
  end

  get '/greet' do
    respond 200, type: :html, body: file('greet.html')
  end

  def call(env)
    request = Rack::Request.new(env)

    verb = request.request_method.downcase.to_sym
    path = Rack::Utils.unescape(request.path_info)

    route = self.class.routes.match(verb, path)
    if route.nil?
      [404, { 'Content-Type' => 'text/plain' }, ['Not found']]
    else
      route.action.call(*route.values.push(request.params))
    end
  end
end
