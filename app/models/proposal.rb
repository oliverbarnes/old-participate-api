class Proposal
  include Mongoid::Document

  belongs_to :author, class_name: 'Participant'
  has_many   :supports
  has_many   :suggestions

  field :title
  field :body

  def support_count
    supports.count
  end
end
