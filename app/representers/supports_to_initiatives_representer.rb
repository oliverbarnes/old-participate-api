require 'representable/json/collection'

module SupportsToInitiativesRepresenter
  include Representable::JSON::Collection

  self.representation_wrap = :supports_to_initiatives

  items extend: SupportToInitiativeRepresenter
end