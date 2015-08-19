require 'rails_helper'

describe 'Access Tokens API' do
  describe 'with Facebook login' do
    describe 'POST /tokens' do
      let!(:user_data) { stub_facebook_requests! }

      let(:name)   { user_data[:name] }
      let(:email)  { user_data[:email] }
      let(:login)  { Login.find_by(email: email) }

      let(:params) { { auth_code: 'authenticationcode' } }

      subject { post '/tokens', params }

      it '200 OK' do
        subject

        expect(response).to have_http_status(200)
      end

      it 'creates a login' do
        expect { subject }.to change { Login.where(email: email).count }.by(1)
      end

      it 'creates a participant' do
        expect { subject }.to change { Participant.where(name: name).count }.by(1)
      end

      it 'responds with an access token' do
        subject

        expect(response.body).to be_json_eql({ access_token: login.access_token }.to_json)
      end

      context 'a login already exists' do
        before { Login.create(email: email, facebook_uid: user_data[:id]) }

        it 'does not create another login' do
          expect { subject }.to change { Login.where(email: email).count }.by(0)
        end

        it 'does not create another participant' do
          expect { subject }.to change { Participant.where(name: name).count }.by(0)
        end

        it 'responds with an access token' do
          subject

          expect(response.body).to be_json_eql({ access_token: login.access_token }.to_json)
        end

      end

      context 'when auth code is not present' do
        let(:params) { {} }

        it '400 Bad request' do
          subject

          expect(response).to have_http_status(400)
        end

        it 'responds with a error message' do
          subject

          expect(response.body).to eql('{"error":"facebook auth code missing"}')
        end
      end

      context 'when Facebook responds with an error' do
        before do
          stub_facebook_and_return_error!
        end

        it '500 Internal server error' do
          subject

          expect(response).to have_http_status(500)
        end

        it 'responds with an empty response body' do
          subject

          expect(response.body).to eql('')
        end
      end
    end
  end
end
