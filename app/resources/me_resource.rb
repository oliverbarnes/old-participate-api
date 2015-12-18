require 'jsonapi/resource'

class MeResource < JSONAPI::Resource
  model_name 'Participant'

  attributes :name

  has_many :supports
end
