require 'roar/representer/json'

module IssueRepresenter
  include Roar::Representer::JSON

  property :id
  property :title
  property :description
  property :author_id
end