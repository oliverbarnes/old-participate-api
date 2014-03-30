module LiquidFeedback
  class API < Grape::API
    format :json

    mount ::LiquidFeedback::Issues
    mount ::LiquidFeedback::Votes
    mount ::LiquidFeedback::Delegations
    mount Raddocs::App => "/docs"
  end
end