require 'spec_helper'

resource 'Areas' do
  header 'Accept', 'application/vnd.api+json'
  header 'Content-Type', 'application/vnd.api+json'

  let(:area) { FactoryGirl.create( :area ) }
  let(:area_representation) { %{{ 
                                 "areas": [{ 
                                    "id": "#{area.id}",
                                    "name": "#{area.name}", 
                                    "description": "#{area.description}"
                                  }]
                                }} }

  get '/areas/:id' do
    let(:id) { area.id }

    example_request "Getting a specific area" do
      expected = JSON.parse( area_representation )
      expect( JSON.parse( response_body) ).to eql expected
      status.should == 200
    end

    context 'non-existing id' do
      let(:id) { 'idontexist' }

      example_request "Area not found" do
        expect( JSON.parse( response_body) ).to eql( {'error' => 'Area not found'} )
        status.should == 404
      end
    end
  end

  get '/areas' do

    example_request "Listing areas" do
      expected = JSON.parse( area_representation )
      do_request #hack to get response_body to populate - example_request() should already have made the request
      expect( JSON.parse( response_body) ).to eql expected
      status.should == 200
    end
  end

  post '/areas' do
    parameter :name, "Name of the area", required: true
    parameter :description, "Description of the area"

    let(:raw_post) do 
      { name: 'new area', description: 'new area description' }.to_json
    end

    let(:area_id) { Area.last.id }
    let(:area_representation) { %{ { 
                                     "areas": [{
                                        "id": "#{area_id}",
                                        "name": "#{'new area'}", 
                                        "description": "#{'new area description'}"
                                      }]
                                   } } }

    example "Posting a new area" do
      do_request
      status.should == 201
      expected = JSON.parse( area_representation )
      expect( JSON.parse( response_body) ).to eql expected
    end
  end

  patch '/areas' do
    parameter :id, "Area id", required: true
    parameter :name, "Name of the area"
    parameter :description, "Description of the area"

    let(:raw_post) do 
      { id: area.id, name: 'new name', description: 'new description' }.to_json
    end
    let(:area_representation) { %{{ 
                                     "areas": [{
                                        "id": "#{area.id}",
                                        "name": "new name", 
                                        "description": "new description"
                                      }]
                                 }} }

    example "Updating an area" do
      do_request
      status.should == 200
      expected = JSON.parse( area_representation )
      expect( JSON.parse( response_body) ).to eql expected
    end
  end

  delete '/areas/:id' do
    let(:id) { FactoryGirl.create( :area ).id }
    
    example_request "Removing a area" do
      status.should == 200
    end
  end
end