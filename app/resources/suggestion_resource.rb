require 'jsonapi/resource'

class SuggestionResource < Base
  attributes :body

  has_one :author, class_name: 'Participant'
  has_one :proposal
end
