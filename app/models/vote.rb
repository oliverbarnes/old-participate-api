class Vote
  include Mongoid::Document
  include Mongoid::Timestamps

  field :issue_id
end