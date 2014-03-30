require 'roar/representer/json'

module DelegationRepresenter
  include Roar::Representer::JSON

  property :issue_id
  property :truster_id
  property :trustee_id
end