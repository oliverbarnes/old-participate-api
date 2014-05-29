require 'representable/json/collection'

module SuggestionsToInitiativesRepresenter
  include Representable::JSON::Collection

  self.representation_wrap = :suggestions_to_initiatives

  items extend: SuggestionToInitiativeRepresenter
end