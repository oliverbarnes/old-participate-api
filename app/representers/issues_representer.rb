require 'representable/json/collection'

module IssuesRepresenter
  include Representable::JSON::Collection

  items extend: IssueRepresenter
end