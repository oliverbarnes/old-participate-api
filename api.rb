module LiquidFeedback
  class API < Grape::API
    format :json

    mount ::LiquidFeedback::Issues
  end
end