require 'rails_helper'

describe 'Me API' do
  include_context 'headers and login'

  describe 'GET /me' do

    subject { get '/me', {}, headers }

    it '200 OK' do
      subject

      expect(response.status).to eq 200
    end

    it 'current participant' do
      subject

      expected = {
        data: {
          id: current_participant.id,
          type: 'participants',
          links: {
            self: "http://www.example.com/participants/#{current_participant.id}"
          }
        }
      }.to_json

      expect(response.body).to be_json_eql(expected)
    end

    it_behaves_like 'token is invalid'
  end
end
