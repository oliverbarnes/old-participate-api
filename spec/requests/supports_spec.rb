require 'rails_helper'

describe 'Supports API' do
  include_context 'headers and login'

  let(:proposal)   { FactoryGirl.create(:proposal) }

  describe 'POST /proposals/:proposal_id/supports' do
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

    subject { post "/proposals/#{proposal.id}/supports", params.to_json, headers }

    it 'creates new support to related proposal' do
      expect(Support.count).to eql 0
      subject
      expect(new_support.proposal).to eql proposal
    end

    it '201 Created' do
      subject

      expect(response.status).to eq 201
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
