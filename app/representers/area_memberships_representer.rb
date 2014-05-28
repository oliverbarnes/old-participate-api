require 'representable/json/collection'

module AreaMembershipsRepresenter
  include Representable::JSON::Collection

  self.representation_wrap = :area_memberships

  items extend: AreaMembershipRepresenter
end