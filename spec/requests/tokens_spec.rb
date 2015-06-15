require 'rails_helper'

# - 'Facebook' object, not 'FacebookAuthenticator'
# - tokens controller, not oauth2
# - no doorkeeper, just oauth2 gem
# - jwt
# - encapsulate connect/create from facebook into Login

describe 'Access Tokens API' do
  describe 'with Facebook login' do
    describe 'POST /tokens' do
      let(:email)  { 'sljfqyn_fergiesen_1434326573@tfbnw.net' }
      let(:login)  { Login.find_by(email: email) }
      let(:params) { { facebook_app_token: '1583083701926004|YfXgmPo41REJ21G4irTxUgbh0wA' } }

      subject { post '/tokens', params }

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
