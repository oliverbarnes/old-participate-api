class SupportsController < ResourceController
  prepend_before_action :include_proposal_support_count, only: :create
  prepend_before_action :include_place_holder_me_id, only: :get_related_resources

  # Hack to implement default includes (as opposed to ones coming as request params)
  # Default includes are actually blessed by the jsonapi spec
  # https://github.com/cerebris/jsonapi-resources/issues/389
  def include_proposal_support_count
    include_directives = {
      include: 'proposal',
      fields: {
        proposals: 'support-count'
      }
    }
    params.merge! include_directives
  end

  # Hack to #get_related_resources to work with singleton resources
  def include_place_holder_me_id
    params.merge!({ me_id: 'placeholder' })
  end
end
