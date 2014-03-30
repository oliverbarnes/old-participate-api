class Delegation
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :truster, class_name: 'Member', inverse_of: :delegation
  belongs_to :trustee, class_name: 'Member', inverse_of: :delegation
  belongs_to :issue
end