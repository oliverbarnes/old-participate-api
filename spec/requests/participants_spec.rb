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
end
