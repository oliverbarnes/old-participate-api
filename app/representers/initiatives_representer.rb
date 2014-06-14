require 'representable/json/collection'

module InitiativesRepresenter
  include Representable::JSON::Collection

  self.representation_wrap = :initiatives

  items extend: InitiativeRepresenter
end