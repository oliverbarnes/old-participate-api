require 'spec_helper'

resource 'Votes' do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  post '/votes' do
  	parameter :issue_id, "Issue being voted on", required: true

  	let(:issue) { FactoryGirl.create :issue }
  	let(:vote_representation) { %{ {"issue_id": "#{issue.id}"} } }
    let(:raw_post) do 
      { issue_id: issue.id  }.to_json
    end

  	example "Posting a new vote on a issue" do
      do_request( issue_id: issue.id )
      status.should == 201
      expected = JSON.parse( vote_representation )
      expect( JSON.parse( response_body) ).to eql expected
    end
  end

  delete '/votes/:id' do
    let(:id) { FactoryGirl.create( :vote ).id }
    
    example_request "Removing a vote" do
      status.should == 200
    end
  end

end