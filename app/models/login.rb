class Login
  include Mongoid::Document

  # TODO: belongs_to :owner, class: User

  # TODO: these will move into the User class
  has_many :proposals
  has_many :supports

  field :email
  field :facebook_uid

  # TODO: add spec
  def access_token
    JWT.encode({ uid: facebook_uid, exp: 1.day.from_now.to_i }, Rails.application.secrets.secret_key_base)
  end

  class << self
    # TODO: add spec
    def authenticate!(token = '')
      secret_key = Rails.application.secrets.secret_key_base
      uid = JWT.decode(token, secret_key)[0]['uid']
      find_by(facebook_uid: uid)
    end
  end
end
