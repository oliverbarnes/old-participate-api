class Area
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :description

  has_many :issues
  has_many :memberships, class_name: 'AreaMembership'
end