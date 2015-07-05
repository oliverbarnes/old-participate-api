class Support
  include Mongoid::Document

  belongs_to :login
  belongs_to :proposal

  after_destroy :destroy_suggestions_by_owner_on_previously_supported_proposal

  def destroy_suggestions_by_owner_on_previously_supported_proposal
    # FIXME: there's got to be an equivalent to AR's #destroy_all
    login.suggestions.find_by(proposal: proposal).to_a.each(&:destroy) unless login.suggestions.empty?
  end

end
