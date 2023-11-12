require 'socket'
require 'date'
require 'securerandom'
require 'sinatra'
require 'json'

ruby_response = {
    "language" => "💎 ruby",
    "hostname" => Socket.gethostname,
    "timestamp" => DateTime.now(),
    "uuid" => SecureRandom.uuid,
}

set :port, ENV['PORT'] || 8080
set :bind, '0.0.0.0'

before do
  content_type :json
end

get '/' do
  ruby_response
end

get '/health' do
  {"status" => "ok"}
end

after do
  response.body = JSON.dump(response.body)
end
