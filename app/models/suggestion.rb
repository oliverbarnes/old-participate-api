class Suggestion
  include Mongoid::Document
  include Mongoid::Timestamps

  field :body

  belongs_to :initiative
end