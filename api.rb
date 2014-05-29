module Participate
  class API < Grape::API
    format :json

    mount ::Participate::Root
    mount ::Participate::Areas
    mount ::Participate::AreaMemberships
    mount ::Participate::Issues
    mount ::Participate::InterestsInIssues
    mount ::Participate::Initiatives
    mount ::Participate::SupportsToInitiatives
    mount ::Participate::SuggestionsToInitiatives
    mount ::Participate::Votes
    mount ::Participate::Delegations
    mount Raddocs::App => '/docs'
  end
end