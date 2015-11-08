# Used in the Suggestion model, ensuring the target Proposal is supported
class SupportedValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, 'must be supported' unless supported?(record, attribute, value)
  end

  private

    def supported?(record, attribute, value)
      record.author.supports.count(attribute => value) > 0
    end
end
