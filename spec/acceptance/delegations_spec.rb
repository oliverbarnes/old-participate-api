require 'spec_helper'

resource 'Delegations' do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  post '/delegations' do
    parameter :issue_id, "Issue being delegated", required: true
    parameter :truster_id, "Member delegating their vote", required: true
    parameter :trustee_id, "Member receiving delegation of vote", required: true

    let(:issue) { FactoryGirl.create :issue }
    let(:truster) { FactoryGirl.create :member }
    let(:trustee) { FactoryGirl.create :member }
    let(:delegation_representation) { %{{ 
                                          "issue_id": "#{issue.id}",
                                          "truster_id": "#{truster.id}",
                                          "trustee_id": "#{trustee.id}"
                                        }} }
    let(:raw_post) do 
      { issue_id: issue.id, truster_id: truster.id, trustee_id: trustee.id  }.to_json
    end

    example "Posting a new delegation on a issue" do
      do_request
      status.should == 201
      expected = JSON.parse( delegation_representation )
      expect( JSON.parse( response_body) ).to eql expected
    end
  end

  delete '/delegations/:id' do
    let(:id) { FactoryGirl.create( :delegation ).id }
    
    example_request "Removing a delegation" do
      status.should == 200
    end
  end

end