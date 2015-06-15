class TokensController < ApplicationController

  def create
    facebook_user = Facebook.fetch_user(params[:facebook_app_token])
    login = Login.find_or_create_by(email: facebook_user[:email], facebook_uid: facebook_user[:id])

    render json: { token: login.access_token }
  rescue Facebook::APIError
    render nothing: true, status: 500
  end
end
