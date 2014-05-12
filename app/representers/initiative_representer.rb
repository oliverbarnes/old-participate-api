require 'roar/representer/json'

module InitiativeRepresenter
  include Roar::Representer::JSON

  property :title
  property :draft
  property :author_id
  property :area_id
  property :issue_id
end