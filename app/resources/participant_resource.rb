require 'jsonapi/resource'

class ParticipantResource < Base
  attributes :name

  has_many :supports
  has_many :delegations_given, class_name: 'Delegation'

  filters :exclude_author_of_proposal

  class << self
    def apply_filter(records, filter, value, _)
      if filter == :exclude_author_of_proposal
        proposal_author_id = Proposal.find(value).first.author.id
        records.where(:id.ne => proposal_author_id)
      else
        return super(records, filter, value)
      end
    end

    def records(options = {})
      context = options[:context]
      current_participant = context[:current_participant]
      _model_class.where(:id.nin => [current_participant.id])
    end
  end
end
