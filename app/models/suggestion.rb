class Suggestion

  include Mongoid::Document

  belongs_to :participant
  belongs_to :proposal

  field :body

  validates :proposal, supported: true
end
