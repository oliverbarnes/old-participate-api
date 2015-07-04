class Suggestion
  include Mongoid::Document

  belongs_to  :login
  belongs_to  :proposal

  field :body
end
