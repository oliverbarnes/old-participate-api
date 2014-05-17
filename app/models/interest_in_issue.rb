class InterestInIssue
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :issue
  belongs_to :member
end