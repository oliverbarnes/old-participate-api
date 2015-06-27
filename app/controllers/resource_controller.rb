class ResourceController < ApplicationController
  rescue_from Forbidden, with: :forbidden_response

  # TODO: don't authenticate :index nor :show
  before_action :authenticate!

  include JSONAPI::ActsAsResourceController

  def create_operations_processor
    TempMongoidOperationsProcessor.new
  end

  def context
    # FIXME: method is being passed because of authorization kludge
    { current_user: current_user, request_method: request.method }
  end
end
