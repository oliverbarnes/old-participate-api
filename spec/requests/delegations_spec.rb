require 'rails_helper'

describe 'Delegations API' do
  include_context 'headers and login'

  let(:proposal) { FactoryGirl.create(:proposal) }
  let(:delegate) { FactoryGirl.create(:participant) }

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

    context 'creates a new delegation associated to' do
      before { subject }

      it 'a proposal' do
        expect(new_delegation.proposal).to eql proposal
      end

      it 'a delegate' do
        expect(new_delegation.delegate).to eql delegate
      end

      it 'an author' do
        expect(new_delegation.author).to eql current_participant
      end
    end

    context 'without a proposal' do
      let(:params) do
        {
          data: {
            type: 'delegations',
            relationships: {
              delegate: {
                data: { type: 'delegates', 'id': delegate.id.to_s }
              }
            }
          }
        }
      end

      it '422 Unprocessable entity' do
        subject

        expect(response.status).to eql 422
      end
    end

    context 'without a delegate' do
      let(:params) do
        {
          data: {
            type: 'delegations',
            relationships: {
              proposal: {
                data: { type: 'proposals', 'id': proposal.id.to_s }
              }
            }
          }
        }
      end

      it '422 Unprocessable entity' do
        subject

        expect(response.status).to eql 422
      end
    end
  end
end
