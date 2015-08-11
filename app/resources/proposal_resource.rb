require 'jsonapi/resource'

class ProposalResource < Base
  attributes :title, :body

  has_one :author, class_name: 'Participant'
end
