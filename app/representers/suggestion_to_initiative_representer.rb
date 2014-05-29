require 'roar/representer/json'

module SuggestionToInitiativeRepresenter
  include Roar::Representer::JSON

  property :id
  property :body
  property :initiative_id
end