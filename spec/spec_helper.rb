ENV["RACK_ENV"] ||= 'test'

require './app'
require 'rack/test'

include Rack::Test::Methods

require 'rspec_api_documentation/dsl'
require 'factories'
require 'database_cleaner'

def app
  LiquidFeedback::API
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