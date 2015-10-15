require 'jsonapi/resource'

class SupportResource < Base
  has_one :author
  has_one :proposal

  filters :proposal_id, :author_id

  after_update :trigger_422_on_failed_validations

  # HACK, validation on model isn't triggering JR's 422 response
  def trigger_422_on_failed_validations
    raise JSONAPI::Exceptions::ValidationErrors.new(self) unless @model.valid?
  end

  class << self
    def apply_filter(records, filter, value, options = {})
      value = fix_filter_value(value)
      super(records, filter, value, options)
    end

    private

      # Bug in JR wraps filter values in an array.
      def fix_filter_value(value)
        value.is_a?(Array) ? value.first : value
      end
  end
end
