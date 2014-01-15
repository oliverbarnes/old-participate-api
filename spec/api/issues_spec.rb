require 'spec_helper'

describe LiquidFeedback::Issues  do

  describe 'GET /issues' do
    it 'outputs loads' do
      get "/issues"
      last_response.status.should == 200
      JSON.parse(last_response.body)["issues"].should == "loads"
    end
  end
end