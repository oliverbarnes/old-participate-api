class Base < JSONAPI::Resource
  before_replace_fields :associate_owner
  before_update :authorize_ownership!
  before_remove :authorize_ownership!

  # TODO: add spec
  def associate_owner
    @model.participant = context[:current_participant]
  end

  # TODO: add spec
  def authorize_ownership!
    raise Forbidden unless owned_by_current_participant?
  end

  class << self
    # Accept mongo ids
    def verify_key(key, _context = nil)
      key && String(key)
    end
  end

  private

    def owned_by_current_participant?
      # FIXME: dirty hack, before_update also runs on creation
      # maybe authorization needs to be done in an operation callback
      return true if context[:request_method] == 'POST'
      @model.participant.id.to_s == context[:current_participant].id.to_s
    end
end
