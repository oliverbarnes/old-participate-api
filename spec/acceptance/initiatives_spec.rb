require 'spec_helper'

resource 'Initiatives' do
  header 'Accept', 'application/json'
  header 'Content-Type', 'application/json'

  let(:initiative) { FactoryGirl.create( :initiative ) }
  let(:author) { initiative.author }
  let(:initiative_representation) { %{{ 
                                   "title": "#{initiative.title}", 
                                   "description": "#{initiative.description}",
                                   "author_id": "#{author.id}"
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
    parameter :description, "Description of the initiative", required: true
    parameter :author_id, "Author of the initiative", required: true

    let(:raw_post) do 
      { title: initiative.title, description: initiative.description, author_id: author.id }.to_json
    end

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
    parameter :description, "Description of the initiative"

    let(:raw_post) do 
      { id: initiative.id, title: 'new title', description: 'new description' }.to_json
    end
    let(:initiative_representation) { %{{ 
                                   "title": "new title", 
                                   "description": "new description",
                                   "author_id": "#{author.id}"
                                 }} }

    example "Updating an initiative" do
      do_request
      status.should == 200
      expected = JSON.parse( initiative_representation )
      expect( JSON.parse( response_body) ).to eql expected
    end
  end

  delete '/initiatives/:id' do
    let(:id) { FactoryGirl.create( :initiative ).id }
    
    example_request "Removing a initiative" do
      status.should == 200
    end
  end
end