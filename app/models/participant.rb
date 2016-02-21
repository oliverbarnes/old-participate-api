class Participant
  include Mongoid::Document

  has_one  :login
  has_many :proposals, inverse_of: :author
  has_many :supports
  has_many :suggestions

  has_many :delegations_given, class_name: 'Delegation', inverse_of: :author
  has_many :delegations_received, class_name: 'Delegation', inverse_of: :delegate
  belongs_to :proposal, inverse_of: :delegates

  has_many :delegates, class_name: 'Participant'
  belongs_to :participant, inverse_of: :delegates

  field :name
end
