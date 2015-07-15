class TokensController < ApplicationController

  def create
    render_bad_request && return unless params[:auth_code]

    facebook_user = Facebook.fetch_user(params[:auth_code])
    login = Login.find_or_create_by(email: facebook_user[:email], facebook_uid: facebook_user[:id])

    render json: { access_token: login.access_token }
  rescue Facebook::APIError
    render nothing: true, status: 500
  end

  private

    def render_bad_request
      render json: { error: 'facebook auth code missing' }, status: 400
    end
end
