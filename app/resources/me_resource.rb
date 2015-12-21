require 'jsonapi/resource'

class MeResource < JSONAPI::Resource
  self._type = :me

  model_name 'Participant'

  attributes :name

  has_many :supports

  def self.find_by_key(_, options)
    context = options[:context]
    MeResource.new(context[:current_participant], options)
  end
end
