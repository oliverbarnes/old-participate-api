require 'spec_helper'

resource 'SupportsToInitiatives' do
  header 'Accept', 'application/vnd.api+json'
  header 'Content-Type', 'application/vnd.api+json'

  let(:support) { FactoryGirl.create :support_to_initiative }
  let(:initiative) { support.initiative }
  let(:member) { support.member }
  let(:support_representation) { %{{ 
                                     "supports_to_initiatives": [{
                                        "id": "#{support.id}",
                                        "initiative_id": "#{initiative.id}", 
                                        "member_id": "#{member.id}"
                                     }]
                                 }} }

  get '/supports_to_initiatives/:id' do
    let(:id) { support.id }

    example_request "Getting a specific support to a initiative" do
      expected = JSON.parse( support_representation )
      expect( JSON.parse( response_body) ).to eql expected
      status.should == 200
    end

    context 'non-existing id' do
      let(:id) { 'idontexist' }

      example_request "Support to initiative not found" do
        expect( JSON.parse( response_body) ).to eql( {'error' => 'Support to initiative not found'} )
        status.should == 404
      end
    end
  end

  get '/supports_to_initiatives' do

    example_request "Listing supports to initiatives" do
      expected = JSON.parse( support_representation )
      do_request 
      expect( JSON.parse( response_body) ).to eql expected
      status.should == 200
    end
  end

  post '/supports_to_initiatives' do
    parameter :initiative_id, "Supported initiative", required: true
    parameter :member_id, "Supporting member", required: true

    let(:raw_post) do 
      { initiative_id: initiative.id, member_id: member.id }.to_json
    end
    let(:support_id) { SupportToInitiative.last.id }
    let(:support_representation) { %{ { 
                                     "supports_to_initiatives": [{
                                        "id": "#{support_id}",
                                        "initiative_id": "#{initiative.id}", 
                                        "member_id": "#{member.id}"
                                      }]
                                   } } }

    example "Posting new support to a initiative" do
      do_request
      status.should == 201
      expected = JSON.parse( support_representation )
      expect( JSON.parse( response_body) ).to eql expected
    end
  end

  delete '/supports_to_initiatives/:id' do
    let(:id) { support.id }
    
    example_request "Removing support to initiative" do
      status.should == 200
    end
  end

end