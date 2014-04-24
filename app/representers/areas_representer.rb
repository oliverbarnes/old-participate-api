require 'representable/json/collection'

module AreasRepresenter
  include Representable::JSON::Collection

  items extend: AreaRepresenter
end