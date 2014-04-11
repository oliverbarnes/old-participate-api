class Delegation
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :truster, class_name: 'Member', inverse_of: :delegation
  belongs_to :trustee, class_name: 'Member', inverse_of: :delegation
  belongs_to :issue
  field :area_id

  before_create :increment_trustee_voting_weight
  before_destroy :decrement_trustee_voting_weight

  private

    def increment_trustee_voting_weight
      trustee.increment_voting_weight!
    end

    def decrement_trustee_voting_weight
      trustee.decrement_voting_weight!
    end
end