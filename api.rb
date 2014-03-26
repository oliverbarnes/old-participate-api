module LiquidFeedback
  class API < Grape::API
    format :json

    mount ::LiquidFeedback::Issues
    mount ::LiquidFeedback::Votes
    mount Raddocs::App => "/docs"
  end
end