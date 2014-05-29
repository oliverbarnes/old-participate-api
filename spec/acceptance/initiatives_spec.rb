require 'spec_helper'

resource 'Initiatives' do
  header 'Accept', 'application/vnd.api+json'
  header 'Content-Type', 'application/vnd.api+json'

  let(:initiative) { FactoryGirl.create( :initiative ) }
  let(:author) { initiative.author }
  let(:area) { initiative.area }
  let(:issue) { initiative.issue }
  let(:initiative_representation) { %{{ 
                                   "title": "#{initiative.title}", 
                                   "draft": "#{initiative.draft}",
                                   "author_id": "#{author.id}",
                                   "area_id": "#{area.id}",
                                   "issue_id": "#{issue.id}"
                                 }} }

  get '/initiatives/:id' do
    let(:id) { initiative.id }

    example_request "Getting a specific initiative" do
      expected = JSON.parse( initiative_representation )
      expect( JSON.parse( response_body) ).to eql expected
      status.should == 200
    end

    context 'non-existing id' do
      let(:id) { 'idontexist' }

      example_request "Initiative not found" do
        expect( JSON.parse( response_body) ).to eql( {'error' => 'Initiative not found'} )
        status.should == 404
      end
    end
  end

  get '/initiatives' do

    example_request "Listing initiatives" do
      expected = JSON.parse( "[#{initiative_representation}]" )
      do_request #hack to get response_body to populate - example_request() should already have made the request
      expect( JSON.parse( response_body) ).to eql expected
      status.should == 200
    end
  end

  post '/initiatives' do
    parameter :title, "Title of the initiative", required: true
    parameter :draft, "Description of the initiative", required: true
    parameter :author_id, "Author of the initiative", required: true
    parameter :area_id, "Area the initiative belongs to"
    parameter :issue_id, "Issue the initiative belongs to"

    let(:raw_post) do 
      { title: initiative.title, 
        draft: initiative.draft, 
        author_id: author.id,
        issue_id: issue.id }.to_json
    end
    let(:initiative_representation) { %{{ 
                                     "title": "#{initiative.title}", 
                                     "draft": "#{initiative.draft}",
                                     "author_id": "#{author.id}",
                                     "issue_id": "#{issue.id}"
                                   }} }

    example "Posting a new initiative" do
      do_request
      status.should == 201
      expected = JSON.parse( initiative_representation )
      expect( JSON.parse( response_body) ).to eql expected
    end
  end

  patch '/initiatives' do
    parameter :id, "Initiative id", required: true
    parameter :title, "Title of the initiative"
    parameter :draft, "Description of the initiative"

    let(:raw_post) do 
      { id: initiative.id, title: 'new title', draft: 'new draft' }.to_json
    end
    let(:initiative_representation) { %{{ 
                                   "title": "new title", 
                                   "draft": "new draft",
                                   "author_id": "#{author.id}",
                                   "area_id": "#{area.id}",
                                   "issue_id": "#{issue.id}"
                                 }} }

    example "Updating an initiative" do
      do_request
      status.should == 200
      expected = JSON.parse( initiative_representation )
      expect( JSON.parse( response_body) ).to eql expected
    end

    #TODO: context - can't change area or issue the initiative belongs to
  end

  delete '/initiatives/:id' do
    let(:id) { FactoryGirl.create( :initiative ).id }
    
    example_request "Removing a initiative" do
      status.should == 200
    end
  end
end