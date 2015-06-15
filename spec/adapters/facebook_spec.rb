require 'rails_helper'

describe Facebook do
  describe '.fetch_user' do
    let(:authentication_code)      { 'authenticationcode' }
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

    subject { described_class.fetch_user(authentication_code) }

    it 'returns a hash with the user data' do
      expect(subject).to eql user_data
    end

    context 'on facebook api failure' do
      before do
        stub_facebook_and_return_error!
      end

      it 'raises a ApiError' do
        expect { subject }.to raise_error Facebook::APIError
      end
    end
  end
end
