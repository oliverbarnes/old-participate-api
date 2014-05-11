require 'representable/json/collection'

module SuggestionsRepresenter
  include Representable::JSON::Collection

  items extend: SuggestionRepresenter
end