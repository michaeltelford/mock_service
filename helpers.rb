module Helpers
  CONTENT_TYPES = {
    json:  'application/json',
    html:  'text/html',
    plain: 'text/plain',
  }

  # Sends a rack compliant HTTP response.
  def respond(status, type: :json, headers: {}, body: [])
    empty_body = body.empty?
    headers['Content-Type'] = CONTENT_TYPES[type] unless empty_body

    # If the JSONParser middleware isn't going to be hit...
    if !empty_body && headers['Content-Type'] != CONTENT_TYPES[:json]
      headers['Content-Length'] = body.length.to_s if body.respond_to?(:length)
      body = [body] unless body.respond_to?(:each)
    end

    [status, headers, body]
  end

  # Looks for the file in fixtures and returns its contents as a String.
  def file(name)
    path = "fixtures/#{name}"
    if File.exist?(path) and File.file?(path)
      File.read(path)
    else
      raise "Incorrect path to file: #{path}"
    end
  end
end
