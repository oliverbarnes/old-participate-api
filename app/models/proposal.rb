class Proposal
  include Mongoid::Document

  belongs_to :login
  has_many   :supports

  field :title
  field :body
end
