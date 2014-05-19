require 'representable/json/collection'

module SupportsToInitiativesRepresenter
  include Representable::JSON::Collection

  items extend: SupportToInitiativeRepresenter
end