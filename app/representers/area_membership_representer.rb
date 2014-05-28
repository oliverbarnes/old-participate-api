require 'roar/representer/json'

module AreaMembershipRepresenter
  include Roar::Representer::JSON

  property :id
  property :area_id
  property :member_id
end