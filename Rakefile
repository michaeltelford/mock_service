require 'dotenv/tasks'

task default: :help

desc "Print available rake tasks"
task :help do
  system 'bundle exec rake -T'
end

desc "Run the server locally on ENV['PORT']"
task serve: :dotenv do
  puts "Running the mock server on port #{port}"
  system "bundle exec shotgun -s Thin -o 0.0.0.0 -p #{port}"
end

desc "Builds the mock service docker image"
task :build do
  system 'docker build -t mock_service .'
end

desc "Runs docker-compose up"
task up: :dotenv do
  system "docker-compose up --abort-on-container-exit client"
end

desc "Runs the mock service (only) via docker-compose"
task run: :dotenv do
  system "docker-compose run -p #{port}:#{port} mock"
end

def port
  ENV.fetch('PORT')
end
