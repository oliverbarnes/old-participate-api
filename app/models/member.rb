class Member
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :voting_weight, type: Integer, default: 1

  has_many :votes
  has_many :delegations, inverse_of: :truster
  has_many :delegations, inverse_of: :trustee
  has_many :issues
end