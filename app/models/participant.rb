class Participant
  include Mongoid::Document

  has_one :login
  has_many :proposals
  has_many :supports
  has_many :suggestions

  field :name
end
