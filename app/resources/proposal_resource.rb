require 'jsonapi/resource'

class ProposalResource < Base
  attributes :title, :body, :support_count

  has_one  :author
  has_many :suggestions
  has_many :supports
end
