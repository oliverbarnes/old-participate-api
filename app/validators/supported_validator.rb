class SupportedValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, 'must be supported' unless supported?(record, value)
  end

  def supported?(record, value)
    record.login.supports.count(proposal: value) > 0
  end
end
