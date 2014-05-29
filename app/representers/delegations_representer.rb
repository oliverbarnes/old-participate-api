require 'representable/json/collection'

module DelegationsRepresenter
  include Representable::JSON::Collection

  self.representation_wrap = :delegations

  items extend: DelegationRepresenter
end