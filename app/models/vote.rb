class Vote
  include Mongoid::Document
  include Mongoid::Timestamps

  field :issue_id

  belongs_to :voter, class_name: 'Member'
end