require 'roar/representer/json'

module SupportToInitiativeRepresenter
  include Roar::Representer::JSON

  property :initiative_id
  property :member_id
end