
def respond(status, headers: {}, body: [])
  [status, headers, body]
end

def file(path)
  if File.exist?(path) and File.file?(path)
    File.open(path) { |f| f.read }
  else
    raise "Incorrect path to file: #{path}"
  end
end
