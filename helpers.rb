
# Send a rack compliant HTTP response.
def respond(status, headers: {}, body: [])
  if headers['Content-Type'] != 'application/json' && !body.respond_to?(:each)
    body = [body]
  end
  [status, headers, body]
end

# Looks for the file in fixtures and returns its contents.
def file(name)
  path = "fixtures/#{name}"
  if File.exist?(path) and File.file?(path)
    File.read(path)
  else
    raise "Incorrect path to file: #{path}"
  end
end
