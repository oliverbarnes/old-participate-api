require 'roar/representer/json'

module AreaRepresenter
  include Roar::Representer::JSON

  property :id
  property :name
  property :description
end