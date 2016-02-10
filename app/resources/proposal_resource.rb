require 'jsonapi/resource'

class ProposalResource < Base
  attributes :title, :body, :support_count

  has_one  :author, class_name: 'Participant'
  has_many :suggestions
  has_many :supports
  has_many :delegates, class_name: 'Participant'
end
