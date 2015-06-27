require 'jsonapi/resource'

class SupportResource < JSONAPI::Resource
  before_create :associate_login
  before_update :authorize_ownership!
  before_remove :authorize_ownership!

  has_one :proposal

  # TODO: add spec
  def associate_login
    @model.login = context[:current_user]
  end

  # TODO: add spec
  def authorize_ownership!
    raise Forbidden unless owned_by_current_user?
  end

  class << self
    # Accept mongo ids
    def verify_key(key, _context = nil)
      key && String(key)
    end
  end

  private

    def owned_by_current_user?
      # FIXME: dirty hack, before_update also runs on creation
      # maybe authorization needs to be done in an operation callback
      return true if context[:request_method] == 'POST'
      @model.login.id.to_s == context[:current_user].id.to_s
    end
end
