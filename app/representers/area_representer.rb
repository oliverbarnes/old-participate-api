require 'roar/representer/json'

module AreaRepresenter
  include Roar::Representer::JSON

  property :name
  property :description
end