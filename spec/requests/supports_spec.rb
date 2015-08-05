require 'rails_helper'

describe 'Supports API' do
  include_context 'headers and login'

  let(:proposal)   { FactoryGirl.create(:proposal) }

  describe 'GET /supports?filter[proposal_id]=:proposal_id&filter[participant_id]=:participant_id' do
    let!(:support) { current_participant.supports.create( proposal: proposal ) }
    let(:filter_params) do
      filter  = "filter[proposal_id]=#{proposal.id}"
      filter << "&filter[participant_id]=#{current_participant.id}"
    end

    subject { get "/supports?#{filter_params}", {}, headers  }

    it '200 OK' do
      subject

      expect(response.status).to eq 200
    end

    it 'support resource' do
      subject

      expected = {
        data: [
          {
            id: support.id,
            type: 'supports',
            relationships: {
              participant: {
                links: {
                  related: "http://www.example.com/supports/#{support.id}/participant",
                  self: "http://www.example.com/supports/#{support.id}/relationships/participant"
                }
              },
              proposal: {
                links: {
                  related: "http://www.example.com/supports/#{support.id}/proposal",
                  self: "http://www.example.com/supports/#{support.id}/relationships/proposal"
                }
              }
            },
            links: {
              self: "http://www.example.com/supports/#{support.id}"
            }
          }
        ]
      }.to_json

      expect(response.body).to be_json_eql(expected)
    end

    it_behaves_like 'empty collection' do
      before { Support.first.destroy }
    end
  end

  describe 'POST /supports' do
    let(:params) do
      {
        data: {
          type: 'supports',
          relationships: {
            proposal: {
              data: { type: 'proposals', 'id': proposal.id.to_s }
            }
          }
        }
      }
    end
    let(:new_support)  { Support.first }

    subject { post '/supports', params.to_json, headers }

    it 'associates new support to the current proposal' do
      expect(Support.count).to eql 0
      subject
      expect(new_support.proposal).to eql proposal
    end

    it 'associates new support to the current participant' do
      expect(Support.count).to eql 0
      subject
      expect(new_support.participant).to eql current_participant
    end

    it '201 Created' do
      subject

      expect(response.status).to eq 201
    end

    it 'new support resource' do
      subject

      expected = {
        data: {
          id: new_support.id,
          type: 'supports',
          relationships: {
            participant: {
              links: {
                related: "http://www.example.com/supports/#{new_support.id}/participant",
                self: "http://www.example.com/supports/#{new_support.id}/relationships/participant"
              }
            },
            proposal: {
              links: {
                related: "http://www.example.com/supports/#{new_support.id}/proposal",
                self: "http://www.example.com/supports/#{new_support.id}/relationships/proposal"
              }
            }
          },
          links: {
            self: "http://www.example.com/supports/#{new_support.id}"
          }
        }
      }.to_json

      expect(response.body).to be_json_eql(expected)
    end

    it_behaves_like 'token is invalid'
  end

  describe 'DELETE /supports/:id' do
    let!(:support)     { FactoryGirl.create(:support, proposal: proposal, participant: current_participant) }
    let(:support_id)  { support.id.to_s }

    subject { delete "/supports/#{support_id}", {}, headers }

    it 'destroys the support resource' do
      expect(Support.where(id: support_id).count).to eql 1
      subject
      expect(Support.where(id: support_id).count).to eql 0
    end

    it 'destroys all suggestions on formelly supported proposal by the former supporter' do
      proposal.suggestions << FactoryGirl.create(:suggestion, participant: current_participant)

      expect {
        subject
      }.to change {
        current_participant.suggestions.count(proposal: proposal)
      }.from(1).to(0)
    end

    it '204 No Content' do
      subject

      expect(response.status).to eq 204
    end

    it_behaves_like 'token is invalid'

    it_behaves_like "token doesn't belong to owner" do
      let(:support) { create(:support) }
    end
  end
end
