require 'representable/json/collection'

module InterestsInIssuesRepresenter
  include Representable::JSON::Collection

  items extend: InterestInIssueRepresenter
end