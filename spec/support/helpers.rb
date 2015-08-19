module Helpers
  def stub_facebook_requests!
    token_response = { body: '{ "access_token": "accesstoken" }' }
    user_data = { id: '245234234234', email: 'some@fbuser.com' }
    user_data_response = { body: JSON.generate(user_data), headers: { 'Content-Type' => 'application/json' } }

    stub_request(:get, %r{https://graph.facebook.com/v2.3/oauth/access_token}).to_return(token_response)
    stub_request(:get, 'https://graph.facebook.com/v2.3/me?access_token=access_token&fields=email,name').to_return(user_data_response)

    user_data
  end

  def stub_facebook_and_return_error!
    stub_request(:get, %r{https://graph.facebook.com}).to_return({ status: 500 })
  end
end
