require 'rails_helper'

describe 'Suggestions API' do
  let(:headers) do
    {
      'Accept':        'application/vnd.api+json',
      'Content-type':  'application/vnd.api+json',
      'Authorization': token
    }
  end
  let(:login)      { FactoryGirl.create(:login) }
  let(:token)      { login.access_token }
  let(:proposal)   { FactoryGirl.create(:proposal) }
  let(:suggestion) { FactoryGirl.create(:suggestion, proposal: proposal, login: login) }

  describe 'GET /proposals/:proposal_id/suggestions' do
    let!(:suggestions) { [suggestion] }

    subject { get "/proposals/#{proposal.id}/suggestions", {}, headers }

    it '200 OK' do
      subject

      expect(response.status).to eq 200
    end

    it 'collection of suggestion resources' do
      subject

      expected = {
        data: [
          {
            id: suggestion.id,
            attributes: {
              body:  suggestion.body
            },
            type: 'suggestions',
            links: {
              self: "http://www.example.com/suggestions/#{suggestion.id}"
            },
            relationships: {
              proposal: {
                data: {
                  type: 'proposals'
                },
                links: {
                  related: "http://www.example.com/suggestions/#{suggestion.id}/proposal",
                  self: "http://www.example.com/suggestions/#{suggestion.id}/links/proposal"
                }
              }
            }
          }
        ]
      }.to_json

      expect(response.body).to be_json_eql(expected)
    end
  end

  describe 'GET /suggestions/:id' do

    subject { get "/suggestions/#{suggestion.id}", {}, headers }

    it '200 OK' do
      subject

      expect(response.status).to eq 200
    end

    it 'suggestion resource' do
      subject

      expected = {
        data: {
          id: suggestion.id,
          attributes: {
            body:  suggestion.body
          },
          type: 'suggestions',
          links: {
            self: "http://www.example.com/suggestions/#{suggestion.id}"
          },
          relationships: {
            proposal: {
              data: {
                type: 'proposals'
              },
              links: {
                related: "http://www.example.com/suggestions/#{suggestion.id}/proposal",
                self: "http://www.example.com/suggestions/#{suggestion.id}/links/proposal"
              }
            }
          }
        }
      }.to_json

      expect(response.body).to be_json_eql(expected)
    end
  end

  describe 'POST /proposals/:proposal_id/suggestions' do
    let(:params) do
      {
        data: {
          type: 'suggestions',
          attributes: {
            body:  'New body'
          }
        }
      }
    end
    let(:new_suggestion)  { Suggestion.first }

    subject { post "/proposals/#{proposal.id}/suggestions", params.to_json, headers }

    it 'creates a new suggestion from posted attributes' do
      expect(Suggestion.count).to eql 0
      subject

      expect(new_suggestion.body).to eql params[:data][:attributes][:body]
    end

    it '201 created' do
      subject

      expect(response.status).to eq 201
    end

    it_behaves_like 'token is invalid'
  end

  describe 'PATCH /suggestions/:id' do
    let(:params) do
      {
        data: {
          type: 'suggestions',
          id: suggestion.id.to_s,
          attributes: {
            body:  'New body'
          }
        }
      }
    end

    subject { patch "/suggestions/#{suggestion.id}", params.to_json, headers }

    it "updates suggestion's body" do
      expect {
        subject
      }.to change { suggestion.reload.body }.from(suggestion.body).to(params[:data][:attributes][:body])
    end

    it '200 OK' do
      subject

      expect(response.status).to eq 200
    end

    it_behaves_like 'token is invalid'

    it_behaves_like "token doesn't belong to owner" do
      let(:suggestion) { create(:suggestion) }
    end
  end

  describe 'DELETE /suggestions/:id' do
    let(:suggestion_id) { suggestion.id }

    subject { delete "/suggestions/#{suggestion_id}", {}, headers }

    it 'destroys the suggestion' do
      expect(Suggestion.where(id: suggestion_id).count).to eql 1
      subject
      expect(Suggestion.where(id: suggestion_id).count).to eql 0
    end

    it '204 No Content' do
      subject

      expect(response.status).to eq 204
    end

    it_behaves_like 'token is invalid'

    it_behaves_like "token doesn't belong to owner" do
      let(:suggestion) { create(:suggestion) }
    end
  end
end
