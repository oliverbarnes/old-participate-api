ENV["RACK_ENV"] ||= 'test'

require './app'
require 'rack/test'

include Rack::Test::Methods

require 'rspec_api_documentation/dsl'
require 'database_cleaner'

Dir[File.expand_path('../factories/*.rb', __FILE__)].each do |file|
  require file
end

def app
  Participate::API
end

RspecApiDocumentation.configure do |config|
  config.app = app
  config.curl_host = 'http://localhost:9292'
  config.format = :json
end

RSpec.configure do |config|
  DatabaseCleaner.strategy = :truncation

  config.before(:each) { DatabaseCleaner.clean }
end