ENV["RACK_ENV"] ||= 'test'

require './app'
require 'rack/test'

include Rack::Test::Methods

require 'factories'

def app
  LiquidFeedback::API
end

RspecApiDocumentation.configure do |config|
  config.app = app
  config.curl_host = 'http://localhost:9292'
  config.format = :json
end

RSpec.configure do |config|
  config.before(:each) { Issue.destroy_all }
end