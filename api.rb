module LiquidFeedback
  class API < Grape::API
    format :json

    mount ::LiquidFeedback::Areas
    mount ::LiquidFeedback::Issues
    mount ::LiquidFeedback::Initiatives
    mount ::LiquidFeedback::Votes
    mount ::LiquidFeedback::Delegations
    mount Raddocs::App => "/docs"
  end
end