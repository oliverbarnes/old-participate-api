require 'jsonapi/resource'

class ParticipantResource < Base
  attributes :name

  def self.records(options = {})
    context = options[:context]
    current_participant = context[:current_participant]
    _model_class.where(:id.nin => [current_participant.id])
  end
end
