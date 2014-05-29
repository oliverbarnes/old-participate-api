require 'spec_helper'

resource 'AreaMemberships' do
  header 'Accept', 'application/vnd.api+json'
  header 'Content-Type', 'application/vnd.api+json'

  let(:membership) { FactoryGirl.create :area_membership }
  let(:area) { membership.area }
  let(:member) { membership.member }
  let(:membership_representation) { %{ { 
                                         "area_memberships": [{
                                            "id": "#{membership.id}",
                                            "area_id": "#{area.id}", 
                                            "member_id": "#{member.id}"
                                          }]
                                       } } }

  get '/area_memberships/:id' do
    let(:id) { membership.id }

    example_request "Getting a specific area membership" do
      expected = JSON.parse( membership_representation )
      expect( JSON.parse( response_body) ).to eql expected
      status.should == 200
    end

    context 'non-existing id' do
      let(:id) { 'idontexist' }

      example_request "Area membership not found" do
        expect( JSON.parse( response_body) ).to eql( {'error' => 'Area membership not found'} )
        status.should == 404
      end
    end
  end

  get '/area_memberships' do

    example_request "Listing area memberships" do
      expected = JSON.parse( membership_representation )
      do_request 
      expect( JSON.parse( response_body) ).to eql expected
      status.should == 200
    end
  end

  post '/area_memberships' do
    parameter :area_id, "Area of membership", required: true
    parameter :member_id, "Area member", required: true

    let(:raw_post) do 
      { area_id: area.id, member_id: member.id }.to_json
    end

    let(:membership_id) { AreaMembership.last.id }

    let(:membership_representation) { %{ { 
                                         "area_memberships": [{
                                            "id": "#{membership_id}",
                                            "area_id": "#{area.id}", 
                                            "member_id": "#{member.id}"
                                          }]
                                       } } }


    example "Posting new area membership" do
      do_request
      status.should == 201
      expected = JSON.parse( membership_representation )
      expect( JSON.parse( response_body) ).to eql expected
    end
  end

  delete '/area_memberships/:id' do
    let(:id) { membership.id }
    
    example_request "Removing membership to area" do
      status.should == 200
    end
  end

end