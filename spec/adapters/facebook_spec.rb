require 'rails_helper'

describe Facebook do
  describe '.fetch_user' do
    let(:authentication_code) { 'authenticationcode' }
    let!(:user_data) { stub_facebook_requests! }

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
