class TokensController < ApplicationController

  before_action :check_for_auth_code

  def create
    facebook_user = Facebook.fetch_user(params[:auth_code])

    email_and_uid = { email: facebook_user[:email], facebook_uid: facebook_user[:id] }

    login = Login.find_or_create_by(email_and_uid) do |login|
      login.participant = Participant.create(name: facebook_user[:name])
      login.save!
    end

    render json: { access_token: login.access_token }
  rescue Facebook::APIError
    render nothing: true, status: 500
  end

  private

    def check_for_auth_code
      render_bad_request && return unless params[:auth_code]
    end

    def render_bad_request
      render json: { error: 'facebook auth code missing' }, status: 400
    end
end
