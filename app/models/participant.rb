class Participant
  include Mongoid::Document

  has_one  :login
  has_many :proposals
  has_many :supports
  has_many :suggestions
  has_many :delegations_given, class_name: 'Delegation', inverse_of: :author
  has_many :delegations_received, class_name: 'Delegation', inverse_of: :delegate

  field :name

  def delegates
    Participant.in(id: delegations_given.pluck(:delegate_id))
  end
end
