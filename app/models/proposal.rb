class Proposal
  include Mongoid::Document

  belongs_to :login
  has_many   :supports
  has_many   :suggestions

  field :title
  field :body
end
