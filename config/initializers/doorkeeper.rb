Doorkeeper.configure do

  orm :mongoid4

  resource_owner_from_assertion do
    response = HTTParty.get("https://graph.facebook.com/me?access_token=#{params[:assertion]}")
    user_data = JSON.parse(response.body)
    # User.find_by_facebook_id(user_data['id'])
  end

  grant_flows %w(assertion)
end
