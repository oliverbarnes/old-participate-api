require 'roar/representer/json'

module SuggestionRepresenter
  include Roar::Representer::JSON

  property :id
  property :body
  property :initiative_id
end