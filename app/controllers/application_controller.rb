class ApplicationController < ActionController::API

  attr_reader :current_user

  rescue_from Forbidden, with: :forbidden_response

  private

    def forbidden_response
      head 403
    end

    def authenticate!
      @current_user = Login.authenticate!(request.headers['Authorization'])
    rescue JWT::DecodeError, Mongoid::Errors::DocumentNotFound
      head 401
    end
end
