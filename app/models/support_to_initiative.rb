class SupportToInitiative
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :initiative
  belongs_to :member
end