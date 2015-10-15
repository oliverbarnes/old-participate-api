class Support
  include Mongoid::Document

  belongs_to :author, class_name: 'Participant'
  belongs_to :proposal, index: true

  # Not triggering 422 on JR.
  # ...probably because we're not using jsonapi_resources to
  # declare the route. forcing JR validation error on resource for now
  #
  validates :proposal, presence: true
  validates :author, presence: true

  after_destroy :destroy_suggestions_by_author_on_previously_supported_proposal

  def destroy_suggestions_by_author_on_previously_supported_proposal
    # FIXME: there's got to be an equivalent to AR's #destroy_all
    author.suggestions.find_by(proposal: proposal).to_a.each(&:destroy) unless author.suggestions.empty?
  end

end
