require 'jsonapi/resource'

class SupportResource < Base
  has_one :participant
  has_one :proposal

  filters :proposal_id, :participant_id

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
