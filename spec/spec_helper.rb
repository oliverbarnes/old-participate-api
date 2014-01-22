ENV["RACK_ENV"] ||= 'test'

require './app'
require 'rack/test'

include Rack::Test::Methods

require 'factories'

def app
  LiquidFeedback::API
end