class ApplicationController < ActionController::API

  def authenticate!
    begin
      @current_user = Login.authenticate!(request.headers['Authorization'])
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      head 401
    end
  end
end
