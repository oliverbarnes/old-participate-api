class Vote
  include Mongoid::Document
  include Mongoid::Timestamps

  field :grade, type: Integer
  field :weight, type: Integer, default: 1

  belongs_to :voter, class_name: 'Member'
  belongs_to :issue

  before_create :calculate_weight

  private

  def calculate_weight
    #TODO: this won't work, since the truster themselves have their own voting weights.
    # So #weight needs to be an attribute of Member.
    # But can we do that and keep the final weight on the vote?

    # Delegation.where( trustee: voter, issue: issue )
  end
end