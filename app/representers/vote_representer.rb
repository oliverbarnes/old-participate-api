require 'roar/representer/json'

module VoteRepresenter
  include Roar::Representer::JSON

  property :issue_id
end