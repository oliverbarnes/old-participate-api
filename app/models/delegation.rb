class Delegation
  include Mongoid::Document

  belongs_to :author, class_name: 'Participant', inverse_of: :delegations_given
  belongs_to :proposal
  belongs_to :delegate, class_name: 'Participant', inverse_of: :delegations_received
end
