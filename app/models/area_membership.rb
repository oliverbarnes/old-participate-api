class AreaMembership
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :area
  belongs_to :member
end