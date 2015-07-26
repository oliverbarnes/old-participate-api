class MeController < ApplicationController
  before_action :authenticate!

  def show
    me_resource = MeResource.new(current_participant, {})

    serialized = JSONAPI::ResourceSerializer.new(MeResource).serialize_to_hash me_resource
    serialized[:data]['type'] = 'me'
    serialized[:data]['links'][:self] = request.url

    render json: serialized.to_json
  end
end
