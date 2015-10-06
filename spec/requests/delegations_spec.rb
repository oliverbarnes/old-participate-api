require 'rails_helper'

describe 'Delegations API' do
  include_context 'headers and login'

  let(:proposal) { FactoryGirl.create(:proposal) }
  let(:delegate) { FactoryGirl.create(:participant)}

  describe 'POST /delegations' do
    let(:params) do
      {
        data: {
          type: 'delegations',
          relationships: {
            proposal: {
              data: { type: 'proposals', 'id': proposal.id.to_s }
            },
            delegate: {
              data: { type: 'delegates', 'id': delegate.id.to_s }
            }
          }
        }
      }
    end
    let(:new_delegation) { Delegation.first }

    subject { post '/delegations', params.to_json, headers }

    it 'creates new delegation' do
      expect(Delegation.count).to eql 0
      subject
      expect(new_delegate.proposal).to eql proposal
    end
  end
end
