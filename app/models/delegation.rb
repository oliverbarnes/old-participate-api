class Delegation
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :truster, class_name: 'Member', inverse_of: :delegation
  belongs_to :trustee, class_name: 'Member', inverse_of: :delegation
  belongs_to :issue

  before_create :increment_trustee_voting_weight
  before_destroy :decrement_trustee_voting_weight

  private

    def increment_trustee_voting_weight
      trustee.inc(:voting_weight, 1)
    end

    def decrement_trustee_voting_weight
      trustee.inc(:voting_weight, -1)
    end
end