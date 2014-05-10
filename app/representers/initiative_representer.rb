require 'roar/representer/json'

module InitiativeRepresenter
  include Roar::Representer::JSON

  property :title
  property :description
  property :author_id
end