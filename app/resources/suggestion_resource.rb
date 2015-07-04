require 'jsonapi/resource'

class SuggestionResource < Base
  attributes :body
  has_one    :proposal
end
