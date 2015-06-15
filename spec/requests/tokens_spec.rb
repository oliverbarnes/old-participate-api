require 'rails_helper'

describe 'Access Tokens API' do
  describe 'with Facebook login' do
    describe 'POST /tokens' do
      let!(:user_data) { stub_facebook_requests! }

      let(:email)  { user_data[:email] }
      let(:login)  { Login.find_by(email: email) }

      let(:params) { { facebook_authentication_code: 'authenticationcode' } }

      subject { post '/tokens', params }

      before { Login.destroy_all }

      it 'succeeds' do
        subject

        expect(response).to have_http_status(200)
      end

      it 'creates a login' do
        expect { subject }.to change { Login.where(email: email).count }.by(1)
      end

      it 'responds with an access token' do
        subject

        expect(response.body).to be_json_eql({ token: login.access_token }.to_json)
      end
    end
  end
end
