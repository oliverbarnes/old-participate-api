require 'spec_helper'

resource 'Votes' do
  header 'Accept', 'application/vnd.api+json'
  header 'Content-Type', 'application/vnd.api+json'

  post '/votes' do
  	parameter :issue_id, "Issue being voted on", required: true
    parameter :voter_id, "Voter", required: true
    parameter :grade, "Grade - positive numbers mean acceptance, negative mean rejection. Value indicates preference (1 is highest)", required: true

  	let(:issue) { FactoryGirl.create :issue }
    let(:voter) { FactoryGirl.create :member }
    let(:vote_id) { Vote.first.id }
  	let(:vote_representation) { %{ { 
                                     "votes": [{
                                        "id": "#{vote_id}",
                                        "issue_id": "#{issue.id}", 
                                        "voter_id": "#{voter.id}",
                                        "grade": 1
                                      }]
                                    } } }
    let(:raw_post) do 
      { issue_id: issue.id, voter_id: voter.id, grade: '1' }.to_json
    end

  	example "Posting a new vote on a issue" do
      do_request
      status.should == 201
      expect( response_headers['Location'] ).to eql "http://example.org/votes/#{vote_id}"
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