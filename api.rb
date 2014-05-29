module Participate
  class API < Grape::API
    content_type :jsonapi, 'application/vnd.api+json'
    format :jsonapi

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