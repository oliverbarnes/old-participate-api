class Suggestion

  include Mongoid::Document

  belongs_to  :login
  belongs_to  :proposal

  field :body

  validates :proposal, supported: true
end
