require 'jsonapi/resource'

class DelegationResource < Base
  has_one :author
  has_one :proposal
  has_one :delegate
end
