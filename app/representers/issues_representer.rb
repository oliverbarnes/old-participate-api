require 'representable/json/collection'

module IssuesRepresenter
  include Representable::JSON::Collection

  self.representation_wrap = :issues

  items extend: IssueRepresenter
end