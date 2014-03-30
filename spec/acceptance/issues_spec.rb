require 'spec_helper'

resource 'Issues' do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'
  # parameter :area_id, "Area the issue belongs to"

  let(:issue) { FactoryGirl.create( :issue ) }
  let(:issue_representation) { %{{ "title": "#{issue.title}", "description": "#{issue.description}" }} }
  # let(:issue_representation) { %{{
  #                                  "name": "#{issue.name}",
  #                                  "area_id": #{issue.area_id},
  #                                  "policy_id": #{issue.policy_id},
  #                                  "admin_notice": "#{issue.admin_notice}",
  #                                  "state": "#{issue.state}",
  #                                  "phase_finished": "#{issue.phase_finished.iso8601}",
  #                                  "created": "#{issue.created.iso8601}",
  #                                  "accepted": "#{issue.accepted.iso8601}",
  #                                  "half_frozen": "#{issue.half_frozen.iso8601}",
  #                                  "fully_frozen": "#{issue.fully_frozen.iso8601}",
  #                                  "closed": "#{issue.closed.iso8601}",
  #                                  "cleaned": "#{issue.cleaned.iso8601}",
  #                                  "admission_time": #{issue.admission_time},
  #                                  "discussion_time": #{issue.discussion_time},
  #                                  "verification_time": #{issue.verification_time},
  #                                  "voting_time": #{issue.voting_time},
  #                                  "snapshot": "#{issue.snapshot.iso8601}",
  #                                  "latest_snapshot_event": "#{issue.latest_snapshot_event}",
  #                                  "population": #{issue.population},
  #                                  "voter_count": #{issue.voter_count},
  #                                  "status_quo_schulze_rank": #{issue.status_quo_schulze_rank}
  #                                 }} }

  get '/issues/:id' do
    let(:id) { issue.id }

    example_request "Getting a specific issue" do
      expected = JSON.parse( issue_representation )
      expect( JSON.parse( response_body) ).to eql expected
      status.should == 200
    end

    context 'non-existing id' do
      let(:id) { 'idontexist' }

      example_request "Issue not found" do
        expect( JSON.parse( response_body) ).to eql( {'error' => 'Issue not found'} )
        status.should == 404
      end
    end
  end

  get '/issues' do
    example_request "Listing issues" do
      expected = JSON.parse( "[#{issue_representation}]" )
      do_request #hack to get response_body to populate - example_request() should already have made the request
      expect( JSON.parse( response_body) ).to eql expected
      status.should == 200
    end
  end

  post '/issues' do
    parameter :title, "Title of the issue", required: true
    parameter :description, "Description of the issue", required: true

    let(:raw_post) do 
      { title: issue.title, description: issue.description }.to_json
    end

    example "Posting a new issue" do
      do_request
      status.should == 201
      expected = JSON.parse( issue_representation )
      expect( JSON.parse( response_body) ).to eql expected
    end
  end
end