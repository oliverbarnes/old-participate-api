require 'grape'
require 'json'

class LiquidFeedback < Grape::API

  get 'hello' do
    { hello: 'world' }.to_json
  end

end