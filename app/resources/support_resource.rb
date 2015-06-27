require 'jsonapi/resource'

class SupportResource < Base
  has_one :proposal
end
