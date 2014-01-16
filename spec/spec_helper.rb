ENV["RACK_ENV"] ||= 'test'

require './app'
require 'rack/test'

include Rack::Test::Methods

def app
  LiquidFeedback::API
end