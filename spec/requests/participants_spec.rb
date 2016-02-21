require 'rails_helper'

describe 'Participants API' do
  include_context 'headers and login'

  let!(:participant) { FactoryGirl.create(:participant) }

  describe 'GET /participants' do
    let(:participants) { [participant] }

    subject { get '/participants', {}, headers }

    before { current_participant }

    it '200 OK' do
      subject

      expect(response.status).to eq 200
    end

    it 'collection of participant resources' do
      subject

      expected = {
        data: [
          {
            id: participant.id,
            attributes: {
              name: participant.name
            },
            type: 'participants',
            links: {
              self: "http://www.example.com/participants/#{participant.id}"
            },
            relationships: {
              delegates: {
                links: {
                  related: "http://www.example.com/participants/#{participant.id}/delegates",
                  self: "http://www.example.com/participants/#{participant.id}/relationships/delegates"
                }
              },
              'delegations-given': {
                links: {
                  related: "http://www.example.com/participants/#{participant.id}/delegations-given",
                  self: "http://www.example.com/participants/#{participant.id}/relationships/delegations-given"
                }
              },
              supports: {
                links: {
                  related: "http://www.example.com/participants/#{participant.id}/supports",
                  self: "http://www.example.com/participants/#{participant.id}/relationships/supports"
                }
              }
            }
          }
        ]
      }.to_json

      expect(response.body).to be_json_eql(expected)
    end

    it 'excludes the current participant' do
      subject

      current_participant_data = {
        id: current_participant.id,
        attributes: {
          name: current_participant.name
        },
        type: 'participants',
        links: {
          self: "http://www.example.com/participants/#{current_participant.id}"
        }
      }.to_json
      expect(JSON.parse(response.body)['data'].to_json).to_not include_json(current_participant_data)
    end

    it_behaves_like 'token is invalid'
  end

  describe 'GET /participants/:id' do

    subject { get "/participants/#{participant.id}", { includes: 'delegations-given,delegates' }, headers }

    it '200 OK' do
      subject

      expect(response.status).to eq 200
    end

    it 'proposal resource' do
      subject

      expected = {
        data: {
          id: participant.id,
          attributes: {
            name: participant.name
          },
          type: 'participants',
          links: {
            self: "http://www.example.com/participants/#{participant.id}"
          },
          relationships: {
            delegates: {
              links: {
                related: "http://www.example.com/participants/#{participant.id}/delegates",
                self: "http://www.example.com/participants/#{participant.id}/relationships/delegates"
              }
            },
            'delegations-given': {
              links: {
                related: "http://www.example.com/participants/#{participant.id}/delegations-given",
                self: "http://www.example.com/participants/#{participant.id}/relationships/delegations-given"
              }
            },
            supports: {
              links: {
                related: "http://www.example.com/participants/#{participant.id}/supports",
                self: "http://www.example.com/participants/#{participant.id}/relationships/supports"
              }
            }
          }
        }
      }.to_json

      expect(response.body).to be_json_eql(expected)
    end

    it_behaves_like 'token is invalid'
  end

  describe 'GET /participants?filter[exclude_author_of_proposal]=:proposal_id' do
    let(:proposal) { FactoryGirl.create(:proposal) }
    let!(:author_of_proposal) { proposal.author }
    let(:filter_params) do
      "filter[exclude_author_of_proposal]=#{proposal.id}"
    end

    subject { get "/participants?#{filter_params}", {}, headers }

    it 'excludes the author of a proposal from the participants collection' do
      subject

      proposal_author_data = {
        id: author_of_proposal.id,
        attributes: {
          name: author_of_proposal.name
        },
        type: 'participants',
        links: {
          self: "http://www.example.com/participants/#{author_of_proposal.id}"
        }
      }.to_json
      expect(JSON.parse(response.body)['data'].to_json).to_not include_json(proposal_author_data)
    end

    it_behaves_like 'token is invalid'
  end
end
