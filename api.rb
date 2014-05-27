module LiquidFeedback
  class API < Grape::API
    format :json

    mount ::LiquidFeedback::Root
    mount ::LiquidFeedback::Areas
    mount ::LiquidFeedback::AreaMemberships
    mount ::LiquidFeedback::Issues
    mount ::LiquidFeedback::InterestsInIssues
    mount ::LiquidFeedback::Initiatives
    mount ::LiquidFeedback::SupportsToInitiatives
    mount ::LiquidFeedback::Suggestions
    mount ::LiquidFeedback::Votes
    mount ::LiquidFeedback::Delegations
    mount Raddocs::App => '/docs'
  end
end