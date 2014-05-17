require 'roar/representer/json'

module InterestInIssueRepresenter
  include Roar::Representer::JSON

  property :issue_id
  property :member_id
end