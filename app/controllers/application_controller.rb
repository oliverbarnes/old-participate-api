class ApplicationController < ActionController::API
  attr_reader :current_participant

  private

    def forbidden_response
      head 403
    end

    def authenticate!
      token = extract_token(request.headers[:authorization])
      @current_participant = Login.authenticate!(token).participant
    rescue JWT::DecodeError, Mongoid::Errors::DocumentNotFound
      head 401
    end

    def extract_token(auth_header)
      auth_header ? auth_header.split(' ').last : ''
    end
end
