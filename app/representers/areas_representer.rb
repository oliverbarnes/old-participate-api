require 'representable/json/collection'

module AreasRepresenter
  include Representable::JSON::Collection

  self.representation_wrap = :areas

  items extend: AreaRepresenter
end