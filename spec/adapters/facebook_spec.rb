require 'rails_helper'

describe Facebook do
  describe '.authenticate' do
    let(:app_token)      { 'apptoken' }
    let(:token_response) { { body: '{ "access_token": "accesstoken" }' } }
    let(:user_data) do
      {
        id:         '245234234234',
        email:      'some@fbuser.com'
      }
    end
    let(:user_data_response) do
      { body: JSON.generate(user_data), headers: { 'Content-Type' => 'application/json' } }
    end

    before do
      stub_facebook_requests!(token_response, user_data_response)
    end

    subject { described_class.authenticate(app_token) }

    it 'returns a hash with the user data' do
      expect(subject).to eql user_data
    end

    context 'on failure' do
      it 'returns nil'
    end
  end
end
