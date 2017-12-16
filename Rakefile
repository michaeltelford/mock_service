task default: :help

desc "Print available rake tasks"
task :help do
  system 'bundle exec rake -T'
end

desc "Run the server on ENV['PORT']"
task :serve do
  puts "Running the mock server on port #{port}..."
  system "bundle exec rackup -s Thin -p #{port}"
end

desc "Builds the docker image"
task :build do
  system 'docker build -t mock_service .'
end

desc "Runs the docker image assuming it's built"
task :run do
  system "docker run --rm --name mock_service -p #{port}:#{port} -e PORT=#{port} mock_service"
end

def port
  ENV.fetch('PORT', 9292)
end
