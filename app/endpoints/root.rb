module Participate
  class Root < Grape::API
    resource '/' do
      desc 'List of resource uris'
      get do
        { 
          initiatives_uri: '/initiatives',
          suggestions_to_initiatives_uri: '/suggestions_to_initiatives',
          supports_to_initiatives_uri: '/supports_to_initiatives',
          issues_uri: '/issues',
          interests_in_issues_uri: '/interests_in_issues',
          areas_uri: '/areas',
          area_memberships_uri: '/area_memberships',
          votes_uri: '/votes',
          delegations_uri: '/delegations'
        }
      end
    end
  end
end