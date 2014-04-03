class Vote
  include Mongoid::Document
  include Mongoid::Timestamps

  field :grade, type: Integer

  belongs_to :voter, class_name: 'Member'
  belongs_to :issue
end