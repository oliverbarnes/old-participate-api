require 'roar/representer/json'

module SuggestionRepresenter
  include Roar::Representer::JSON

  property :body
  property :initiative_id
end