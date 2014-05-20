require 'representable/json/collection'

module AreaMembershipsRepresenter
  include Representable::JSON::Collection

  items extend: AreaMembershipRepresenter
end