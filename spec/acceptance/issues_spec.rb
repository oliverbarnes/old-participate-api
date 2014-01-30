require 'spec_helper'
require 'rspec_api_documentation/dsl'

resource 'Issues' do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  let(:issue) { FactoryGirl.create( :issue ) }

  get "/issues/:id" do
    let(:id) { issue.id }

    example_request "Getting a specific issue" do
      #TODO: fix time discrepancy
      expected = JSON.parse '{"name":"Kofi","area_id":1,"policy_id":1,"admin_notice":"","state":"frozen","phase_finished":"2014-01-30T17:40:34-02:00","created":"2014-01-30T17:40:34-02:00","accepted":"2014-01-30T17:40:34-02:00","half_frozen":"2014-01-30T17:40:34-02:00","fully_frozen":"2014-01-30T17:40:34-02:00","closed":"2014-01-30T17:40:34-02:00","cleaned":"2014-01-30T17:40:34-02:00","admission_time":0,"discussion_time":0,"verification_time":0,"voting_time":0,"snapshot":"2014-01-30T17:40:34-02:00","latest_snapshot_event":"","population":0,"voter_count":0,"status_quo_schulze_rank":0}'
      expect( JSON.parse( response_body) ).to eql expected
      status.should == 200
    end
  end
end