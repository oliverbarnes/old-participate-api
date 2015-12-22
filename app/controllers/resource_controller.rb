class ResourceController < ApplicationController
  rescue_from Forbidden, with: :forbidden_response

  prepend_before_action :include_place_holder_me_id, only: :get_related_resources

  before_action :authenticate!

  include JSONAPI::ActsAsResourceController

  def create_operations_processor
    TempMongoidOperationsProcessor.new
  end

  def context
    # FIXME: method is being passed because of authorization kludge
    { current_participant: current_participant, request_method: request.method }
  end

  # Hack to #get_related_resources to work with singleton resources
  def include_place_holder_me_id
    params.merge!({ me_id: 'placeholder' })
  end
end
