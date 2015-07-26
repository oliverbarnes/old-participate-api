shared_context 'headers and login' do
  let(:headers) do
    {
      'Accept':        'application/vnd.api+json',
      'Content-type':  'application/vnd.api+json',
      'Authorization': "Bearer #{login.access_token}"
    }
  end
  let(:login)       { FactoryGirl.create(:login) }
  let(:current_participant) { login.participant }
end
