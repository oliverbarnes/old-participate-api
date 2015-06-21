class Proposal
  include Mongoid::Document

  belongs_to :login

  field :title
  field :body
end
