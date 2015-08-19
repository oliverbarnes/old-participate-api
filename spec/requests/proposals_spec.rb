require 'rails_helper'

describe 'Proposals API' do
  include_context 'headers and login'

  let(:proposal)    { FactoryGirl.create(:proposal, author: current_participant) }

  describe 'GET /proposals' do
    let!(:proposals) { [proposal] }

    subject { get '/proposals', {}, headers }

    it '200 OK' do
      subject

      expect(response.status).to eq 200
    end

    it 'collection of proposal resources' do
      subject

      expected = {
        data: [
          {
            id: proposal.id,
            attributes: {
              title: proposal.title,
              body:  proposal.body
            },
            type: 'proposals',
            links: {
              self: "http://www.example.com/proposals/#{proposal.id}"
            },
            relationships: {
              author: {
                links: {
                  related: "http://www.example.com/proposals/#{proposal.id}/author",
                  self: "http://www.example.com/proposals/#{proposal.id}/relationships/author"
                }
              },
              suggestions: {
                links: {
                  related: "http://www.example.com/proposals/#{proposal.id}/suggestions",
                  self: "http://www.example.com/proposals/#{proposal.id}/relationships/suggestions"
                }
              },
              supports: {
                links: {
                  related: "http://www.example.com/proposals/#{proposal.id}/supports",
                  self: "http://www.example.com/proposals/#{proposal.id}/relationships/supports"
                }
              }
            }
          }
        ]
      }.to_json

      expect(response.body).to be_json_eql(expected)
    end

    it_behaves_like 'empty collection' do
      before { Proposal.first.destroy }
    end
  end

  describe 'GET /proposals/:id' do

    subject { get "/proposals/#{proposal.id}", {}, headers }

    it '200 OK' do
      subject

      expect(response.status).to eq 200
    end

    it 'proposal resource' do
      subject

      expected = {
        data: {
          id: proposal.id,
          attributes: {
            title: proposal.title,
            body:  proposal.body
          },
          type: 'proposals',
          links: {
            self: "http://www.example.com/proposals/#{proposal.id}"
          },
          relationships: {
            author: {
              links: {
                related: "http://www.example.com/proposals/#{proposal.id}/author",
                self: "http://www.example.com/proposals/#{proposal.id}/relationships/author"
              }
            },
            suggestions: {
              links: {
                related: "http://www.example.com/proposals/#{proposal.id}/suggestions",
                self: "http://www.example.com/proposals/#{proposal.id}/relationships/suggestions"
              }
            },
            supports: {
              links: {
                related: "http://www.example.com/proposals/#{proposal.id}/supports",
                self: "http://www.example.com/proposals/#{proposal.id}/relationships/supports"
              }
            }
          }
        }
      }.to_json

      expect(response.body).to be_json_eql(expected)
    end
  end

  describe 'POST /proposals' do
    let(:params) do
      {
        data: {
          type: 'proposals',
          attributes: {
            title: 'New title',
            body:  'New body'
          }
        }
      }
    end
    let(:new_proposal)  { Proposal.first }

    subject { post '/proposals', params.to_json, headers }

    it 'creates a new proposal from posted attributes' do
      expect(Proposal.count).to eql 0
      subject

      expect(new_proposal.title).to eql params[:data][:attributes][:title]
      expect(new_proposal.body).to eql params[:data][:attributes][:body]
    end

    it '201 Created' do
      subject

      expect(response.status).to eq 201
    end

    it_behaves_like 'token is invalid'
  end

  describe 'PATCH /proposals/:id' do
    let(:params) do
      {
        data: {
          type: 'proposals',
          id: proposal.id.to_s,
          attributes: {
            title: 'New title',
            body:  'New body'
          }
        }
      }
    end

    subject { patch "/proposals/#{proposal.id}", params.to_json, headers }

    it "updates proposal's title" do
      expect {
        subject
      }.to change { proposal.reload.title }.from(proposal.title).to(params[:data][:attributes][:title])
    end

    it "updates proposal's body" do
      expect {
        subject
      }.to change { proposal.reload.body }.from(proposal.body).to(params[:data][:attributes][:body])
    end

    it '200 OK' do
      subject

      expect(response.status).to eq 200
    end

    it_behaves_like 'token is invalid'

    it_behaves_like "token doesn't belong to owner" do
      let(:proposal) { create(:proposal) }
    end
  end

  describe 'DELETE /proposals/:id' do
    let(:proposal_id) { proposal.id }

    subject { delete "/proposals/#{proposal_id}", {}, headers }

    it 'destroys the proposal' do
      expect(Proposal.where(id: proposal_id).count).to eql 1
      subject
      expect(Proposal.where(id: proposal_id).count).to eql 0
    end

    it '204 No Content' do
      subject

      expect(response.status).to eq 204
    end

    it_behaves_like 'token is invalid'

    it_behaves_like "token doesn't belong to owner" do
      let(:proposal) { create(:proposal) }
    end
  end
end
