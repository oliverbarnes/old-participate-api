class Suggestion

  include Mongoid::Document

  belongs_to :author, class_name: 'Participant'
  belongs_to :proposal

  field :body

  validates :proposal, supported: true
end
