require 'rails_helper'

describe 'Supports API' do
  let(:headers) do
    {
      'Accept':        'application/vnd.api+json',
      'Content-type':  'application/vnd.api+json',
      'Authorization': token
    }
  end
  let(:login)    { FactoryGirl.create(:login) }
  let(:token)    { login.access_token }
  let(:proposal) { FactoryGirl.create(:proposal) }
  let(:support)  { FactoryGirl.create(:support, login: login) }

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

    it 'creates new support to related proposal', :focus do
      expect(Support.count).to eql 0
      subject
      expect(new_support.proposal).to eql proposal
    end

    it '201 created' do
      subject

      expect(response.status).to eq 201
    end

    it_behaves_like 'token is invalid'
  end

  describe 'DELETE /supports/:id' do
    let(:support_id) { support.id.to_s }

    subject { delete "/supports/#{support_id}", {}, headers }

    it 'destroys the support resource' do
      expect(Support.where(id: support_id).count).to eql 1
      subject
      expect(Support.where(id: support_id).count).to eql 0
    end

    it '204 No Content' do
      subject

      expect(response.status).to eq 204
    end

    it_behaves_like 'token is invalid'

    it_behaves_like "token doesn't belong to owner", :focus do
      let(:support) { create(:support) }
    end
  end
end
