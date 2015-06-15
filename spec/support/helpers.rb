module Helpers
  def stub_facebook_requests!(token_response, user_data_response)
    stub_request(:get, %r{https://graph.facebook.com/v2.3/oauth/access_token}).to_return(token_response)
    stub_request(:get, 'https://graph.facebook.com/v2.3/me?access_token=access_token&fields=email').to_return(user_data_response)
  end

  def stub_facebook_and_return_error!
    stub_request(:get, %r{https://graph.facebook.com}).to_return({ status: 500 })
  end
end
