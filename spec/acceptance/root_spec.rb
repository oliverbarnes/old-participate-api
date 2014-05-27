require 'spec_helper'

resource 'Root' do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  let(:root_representation) { %{ { 
                                   "initiatives_uri": "/initiatives",
                                   "suggestions_to_initiatives_uri": "/suggestions_to_initiatives",
                                   "supports_to_initiatives_uri": "/supports_to_initiatives",
                                   "issues_uri": "/issues",
                                   "interests_in_issues_uri": "/interests_in_issues",
                                   "areas_uri": "/areas",
                                   "area_memberships_uri": "/area_memberships",
                                   "votes_uri": "/votes",
                                   "delegations_uri": "/delegations"
                                 } } }

  get '/' do
    example_request "Getting list discoverable resources at the root" do
      expected = JSON.parse( root_representation )
      do_request 
      expect( JSON.parse( response_body) ).to eql expected
      status.should == 200
    end
  end
end