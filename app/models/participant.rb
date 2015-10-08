class Participant
  include Mongoid::Document

  has_one  :login
  has_many :proposals
  has_many :supports
  has_many :suggestions
  has_many :delegations_given, class_name: 'Delegation', inverse_of: :delegate
  has_many :delegations_received, class_name: 'Delegation', inverse_of: :author

  field :name
end
