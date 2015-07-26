class ResourceController < ApplicationController
  rescue_from Forbidden, with: :forbidden_response

  before_action :authenticate!, except: [:index, :show]

  include JSONAPI::ActsAsResourceController

  def create_operations_processor
    TempMongoidOperationsProcessor.new
  end

  def context
    # FIXME: method is being passed because of authorization kludge
    { current_participant: current_participant, request_method: request.method }
  end
end
