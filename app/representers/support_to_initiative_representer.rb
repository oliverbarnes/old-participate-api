require 'roar/representer/json'

module SupportToInitiativeRepresenter
  include Roar::Representer::JSON

  property :id
  property :initiative_id
  property :member_id
end