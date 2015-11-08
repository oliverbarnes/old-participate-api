require 'jsonapi/resource'

class DelegationResource < Base
  has_one :author
  has_one :proposal
  has_one :delegate

  filters :proposal_id, :author_id

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
