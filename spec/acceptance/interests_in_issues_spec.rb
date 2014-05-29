require 'spec_helper'

resource 'InterestsInIssues' do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  let(:interest) { FactoryGirl.create :interest_in_issue }
  let(:issue) { interest.issue }
  let(:member) { interest.member }
  let(:interest_representation) { %{{ 
                                    "interests_in_issues": [{
                                       "id": "#{interest.id}",
                                       "issue_id": "#{issue.id}", 
                                       "member_id": "#{member.id}"
                                     }]
                                   }} }

  get '/interests_in_issues/:id' do
    let(:id) { interest.id }

    example_request "Getting a specific interest in a issue" do
      expected = JSON.parse( interest_representation )
      expect( JSON.parse( response_body) ).to eql expected
      status.should == 200
    end

    context 'non-existing id' do
      let(:id) { 'idontexist' }

      example_request "Interest in issue not found" do
        expect( JSON.parse( response_body) ).to eql( {'error' => 'Interest in issue not found'} )
        status.should == 404
      end
    end
  end

  get '/interests_in_issues' do

    example_request "Listing interests in issues" do
      expected = JSON.parse( interest_representation )
      do_request #hack to get response_body to populate - example_request() should already have made the request
      expect( JSON.parse( response_body) ).to eql expected
      status.should == 200
    end
  end

  post '/interests_in_issues' do
    parameter :issue_id, "Issue of interest", required: true
    parameter :member_id, "Interested member", required: true

    let(:raw_post) do 
      { issue_id: issue.id, member_id: member.id }.to_json
    end

    let(:interest_id) { InterestInIssue.last.id }
    let(:interest_representation) { %{ { 
                                     "interests_in_issues": [{
                                       "id": "#{interest_id}",
                                       "issue_id": "#{issue.id}", 
                                       "member_id": "#{member.id}"
                                      }]
                                   } } }

    example "Posting a new interest in a issue" do
      do_request
      status.should == 201
      expected = JSON.parse( interest_representation )
      expect( JSON.parse( response_body) ).to eql expected
    end
  end

  delete '/interests_in_issues/:id' do
    let(:id) { interest.id }
    
    example_request "Removing interest in issue" do
      status.should == 200
    end
  end

end