class Proposal
  include Mongoid::Document

  belongs_to :author, class_name: 'Participant'
  has_many   :supports
  has_many   :suggestions
  has_many   :delegations

  field :title
  field :body

  validates :author, presence: true

  def support_count
    supported? ? sum_of_support_weights : 0
  end

  def delegates
    Participant.in(id: delegations.pluck(:delegate_id))
  end

  private

    def supported?
      supports.count > 0
    end

    def sum_of_support_weights
      supports.map(&:weight).reduce(:+)
    end
end
