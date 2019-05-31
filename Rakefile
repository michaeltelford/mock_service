task default: :help

desc "Print available rake tasks"
task :help do
  system 'bundle exec rake -T'
end

desc "Run the server locally on ENV['PORT']"
task :serve do
  puts "Running the mock server on port #{port}"
  system "bundle exec rackup -s Thin -o 0.0.0.0 -p #{port}"
end

desc "Builds the mock service docker image"
task :build do
  system 'docker build -t mock_service .'
end

desc "Runs docker-compose up"
task :up do
  system "PORT=#{port} docker-compose up --abort-on-container-exit client"
end

desc "Runs the mock service (only) via docker-compose"
task :run do
  system "PORT=#{port} docker-compose run mock"
end

def port
  ENV.fetch('PORT', 9292)
end
