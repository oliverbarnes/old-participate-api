class MeController < ApplicationController
  before_action :authenticate!

  # rubocop:disable Metrics/AbcSize
  def show
    me_resource = MeResource.new(current_participant, {})

    serialized = JSONAPI::ResourceSerializer.new(MeResource).serialize_to_hash me_resource
    # FIXME: gotta be a better way to customize serialization
    # maybe patch JR itself to handle singleton resources like this
    # maybe update JR to latest as well
    serialized[:data]['type'] = 'me'
    serialized[:data]['links'][:self] = request.url
    serialized[:data]['relationships']['supports'][:links][:related] = request.url + '/supports'
    serialized[:data]['relationships']['supports'][:links][:self] = request.url + '/relationships/supports'

    render json: serialized.to_json
  end
  # rubocop:enable Metrics/AbcSize
end
