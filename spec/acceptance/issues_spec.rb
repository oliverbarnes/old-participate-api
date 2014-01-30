require 'spec_helper'
require 'rspec_api_documentation/dsl'

resource 'Issues' do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  let(:issue) { FactoryGirl.create( :issue ) }

  get "/issues/:id" do
    let(:id) { issue.id }

    example_request "Getting a specific issue" do
      response_body.should == '{"name":"Kofi"}'
      status.should == 200
    end
  end
end