require 'jsonapi/resource'

class MeResource < JSONAPI::Resource
  self._type = :me

  model_name 'Participant'

  attributes :name

  has_many :supports
  has_many :delegations_given, class_name: 'Delegation'

  # we're not using a key, but key-checking barfs with placeholder string.
  # part of the singleton resource hack
  key_type :string

  def self.find_by_key(_, options)
    context = options[:context]
    MeResource.new(context[:current_participant], options)
  end
end
