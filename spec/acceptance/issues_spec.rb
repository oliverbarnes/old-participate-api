require 'spec_helper'

resource 'Issues' do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'
  # parameter :area_id, "Area the issue belongs to"

  let(:author) { FactoryGirl.create( :member ) }
  let(:issue) { FactoryGirl.create( :issue, author: author ) }
  let(:issue_representation) { %{{ 
                                   "issues": [{
                                     "id": "#{issue.id}",
                                     "title": "#{issue.title}", 
                                     "description": "#{issue.description}",
                                     "author_id": "#{author.id}"
                                    }]
                                 }} }


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
      expected = JSON.parse( issue_representation )
      do_request #hack to get response_body to populate - example_request() should already have made the request
      expect( JSON.parse( response_body) ).to eql expected
      status.should == 200
    end
  end

  post '/issues' do
    parameter :title, "Title of the issue", required: true
    parameter :description, "Description of the issue", required: true
    parameter :author_id, "Author of the issue", required: true

    let(:raw_post) do 
      { title: 'new issue', description: 'new issue description', author_id: author.id }.to_json
    end

    let(:issue_id) { Issue.last.id }
    let(:issue_representation) { %{ { 
                                     "issues": [{
                                        "id": "#{issue_id}",
                                        "title": "new issue", 
                                        "description": "new issue description",
                                        "author_id": "#{author.id}"
                                      }]
                                   } } }

    example "Posting a new issue" do
      do_request
      status.should == 201
      expected = JSON.parse( issue_representation )
      expect( JSON.parse( response_body) ).to eql expected
    end
  end
end