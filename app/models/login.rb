class Login
  include Mongoid::Document

  field :email
  field :facebook_uid

  # TODO: add spec
  def access_token
    JWT.encode({ uid: facebook_uid, exp: 1.day.from_now.to_i }, Rails.application.secrets.secret_key_base)
  end
end
