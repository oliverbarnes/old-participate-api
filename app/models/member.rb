class Member
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :voting_weight, type: Integer, default: 1

  has_many :votes
  has_many :delegations, inverse_of: :truster
  has_many :delegations, inverse_of: :trustee
  has_many :issues
  has_many :interest_in_issues

  def increment_voting_weight!
    self.inc(:voting_weight, 1)
  end

  def decrement_voting_weight!
    self.inc(:voting_weight, -1)
  end
end