require 'representable/json/collection'

module InitiativesRepresenter
  include Representable::JSON::Collection

  items extend: InitiativeRepresenter
end