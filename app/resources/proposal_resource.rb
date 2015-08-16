require 'jsonapi/resource'

class ProposalResource < Base
  attributes :title, :body

  has_one  :author
  has_many :suggestions
  has_many :supports
end
