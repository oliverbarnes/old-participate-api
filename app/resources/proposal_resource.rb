require 'jsonapi/resource'

class ProposalResource < Base
  attributes :title, :body, :support_count

  has_one  :author, class_name: 'Participant'
  has_many :suggestions
  has_many :supports
  has_many :delegates, class_name: 'Participant'
  has_many :delegations
  has_many :counter_proposals, class_name: 'Proposal'
  has_one  :previous_proposal, class_name: 'Proposal'
end
