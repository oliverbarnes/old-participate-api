require 'rails_helper'

describe 'Delegations API' do
  include_context 'headers and login'

  let(:proposal) { FactoryGirl.create(:proposal) }
  let(:delegate) { FactoryGirl.create(:participant) }

  describe 'GET /me/delegations-given (delegations#get_related_resources {:relationship=>"delegations", :source=>"me"})' do
    let!(:delegation) { current_participant.delegations_given.create( proposal: proposal, delegate: delegate ) }

    subject { get '/me/delegations-given', { relationship: 'delegations_given', source: 'me' }, headers }

    it '200 OK' do
      subject

      expect(response.status).to eq 200
    end

    it 'delegation resource' do
      subject

      expected = {
        data: [
          {
            id: delegation.id,
            type: 'delegations',
            relationships: {
              author: {
                links: {
                  related: "http://www.example.com/delegations/#{delegation.id}/author",
                  self: "http://www.example.com/delegations/#{delegation.id}/relationships/author"
                }
              },
              proposal: {
                links: {
                  related: "http://www.example.com/delegations/#{delegation.id}/proposal",
                  self: "http://www.example.com/delegations/#{delegation.id}/relationships/proposal"
                }
              },
              delegate: {
                links: {
                  related: "http://www.example.com/delegations/#{delegation.id}/delegate",
                  self: "http://www.example.com/delegations/#{delegation.id}/relationships/delegate"
                }
              }
            },
            links: {
              self: "http://www.example.com/delegations/#{delegation.id}"
            }
          }
        ]
      }.to_json

      expect(response.body).to be_json_eql(expected)
    end

    it_behaves_like 'empty collection' do
      before { Delegation.first.destroy }
    end
  end

  describe 'GET /delegations?filter[proposal_id]=:proposal_id&filter[author_id]=:author_id' do
    let!(:delegation) { current_participant.delegations_given.create( proposal: proposal, delegate: delegate ) }
    let(:filter_params) do
      filter = "filter[proposal_id]=#{proposal.id}"
      filter << "&filter[author_id]=#{current_participant.id}"
    end

    subject { get "/delegations?#{filter_params}", {}, headers }

    it '200 OK' do
      subject

      expect(response.status).to eq 200
    end

    it 'delegation resource' do
      subject

      expected = {
        data: [
          {
            id: delegation.id,
            type: 'delegations',
            relationships: {
              author: {
                links: {
                  related: "http://www.example.com/delegations/#{delegation.id}/author",
                  self: "http://www.example.com/delegations/#{delegation.id}/relationships/author"
                }
              },
              proposal: {
                links: {
                  related: "http://www.example.com/delegations/#{delegation.id}/proposal",
                  self: "http://www.example.com/delegations/#{delegation.id}/relationships/proposal"
                }
              },
              delegate: {
                links: {
                  related: "http://www.example.com/delegations/#{delegation.id}/delegate",
                  self: "http://www.example.com/delegations/#{delegation.id}/relationships/delegate"
                }
              }
            },
            links: {
              self: "http://www.example.com/delegations/#{delegation.id}"
            }
          }
        ]
      }.to_json

      expect(response.body).to be_json_eql(expected)
    end

    it_behaves_like 'empty collection' do
      before { Delegation.first.destroy }
    end
  end

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
              data: { type: 'participants', 'id': delegate.id.to_s }
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
                data: { type: 'participants', 'id': delegate.id.to_s }
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

  describe 'DELETE /delegations/:id' do
    let(:delegation) { FactoryGirl.create(:delegation, author: current_participant) }

    subject { delete "/delegations/#{delegation.id}", {}, headers }

    it 'destroys the delegation' do
      expect(Delegation.where(id: delegation.id).count).to eql 1
      subject
      expect(Delegation.where(id: delegation.id).count).to eql 0
    end

    it '204 No Content' do
      subject

      expect(response.status).to eq 204
    end

    it_behaves_like 'token is invalid'

    it_behaves_like "token doesn't belong to owner" do
      let(:delegation) { create(:delegation) }
    end
  end
end
