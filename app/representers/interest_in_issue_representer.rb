require 'roar/representer/json'

module InterestInIssueRepresenter
  include Roar::Representer::JSON

  property :id
  property :issue_id
  property :member_id
end