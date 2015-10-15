class SupportsController < ResourceController
  prepend_before_filter :include_proposal_support_count, only: :create

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
end
