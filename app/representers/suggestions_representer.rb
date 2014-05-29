require 'representable/json/collection'

module SuggestionsRepresenter
  include Representable::JSON::Collection

  self.representation_wrap = :suggestions

  items extend: SuggestionRepresenter
end