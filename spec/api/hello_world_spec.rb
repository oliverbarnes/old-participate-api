require 'spec_helper'

describe LiquidFeedback do
  include Rack::Test::Methods

  def app
    LiquidFeedback
  end

  describe LiquidFeedback do
    describe 'GET /hello' do
      it 'says hello to the world' do
        get "/hello"
        last_response.status.should == 200
        JSON.parse(last_response.body)["hello"].should == "world"
      end
    end
  end
end