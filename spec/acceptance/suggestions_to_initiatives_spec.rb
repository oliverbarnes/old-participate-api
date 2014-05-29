require 'spec_helper'

resource 'Suggestions' do
  header 'Accept', 'application/vnd.api+json'
  header 'Content-Type', 'application/vnd.api+json'

  let(:suggestion) { FactoryGirl.create( :suggestion_to_initiative ) }
  let(:initiative) { suggestion.initiative }
  let(:suggestion_representation) { %{{ 
                                       "suggestions_to_initiatives": [{  
                                         "id": "#{suggestion.id}",
                                         "body": "#{suggestion.body}",
                                         "initiative_id": "#{initiative.id}"
                                        }]
                                     }} }

  get '/suggestions/:id' do
    let(:id) { suggestion.id }

    example_request "Getting a specific suggestion" do
      expected = JSON.parse( suggestion_representation )
      expect( JSON.parse( response_body) ).to eql expected
      status.should == 200
    end
  end

  get '/suggestions' do
    parameter :initiative_id, "Initiative the suggestion is for", required: true

    example_request "Listing suggestions"do
      expected = JSON.parse( suggestion_representation )
      do_request(initiative_id: initiative.id)
      expect( JSON.parse( response_body) ).to eql expected
      status.should == 200
    end
  end

  post '/suggestions' do
    parameter :body, "Description of the suggestion", required: true
    parameter :initiative_id, "Initiative the suggestion is for", required: true

    let(:raw_post) do 
      { body: "new suggestion", initiative_id: initiative.id }.to_json
    end
    let(:suggestion_id) { SuggestionToInitiative.last.id }
    let(:suggestion_representation) { %{ { 
                                     "suggestions_to_initiatives": [{
                                        "id": "#{suggestion_id}",
                                        "body": "new suggestion", 
                                        "initiative_id": "#{initiative.id}"
                                      }]
                                   } } }
    example "Posting a new suggestion" do
      do_request
      status.should == 201
      expected = JSON.parse( suggestion_representation )
      expect( JSON.parse( response_body) ).to eql expected
    end
  end

  patch '/suggestions' do
    parameter :id, "Suggestion id", required: true
    parameter :body, "Body text of the suggestion"

    let(:raw_post) do 
      { id: suggestion.id, body: 'new body' }.to_json
    end
    let(:suggestion_representation) { %{ { 
                                     "suggestions_to_initiatives": [{
                                        "id": "#{suggestion.id}",
                                        "body": "new body", 
                                        "initiative_id": "#{initiative.id}"
                                      }]
                                   } } }

    example "Updating an suggestion" do
      do_request
      status.should == 200
      expected = JSON.parse( suggestion_representation )
      expect( JSON.parse( response_body) ).to eql expected
    end
  end

  delete '/suggestions/:id' do
    let(:id) { FactoryGirl.create( :suggestion_to_initiative ).id }
    
    example_request "Removing a suggestion" do
      status.should == 200
    end
  end
end