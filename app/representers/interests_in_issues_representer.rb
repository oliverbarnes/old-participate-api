require 'representable/json/collection'

module InterestsInIssuesRepresenter
  include Representable::JSON::Collection

  self.representation_wrap = :interests_in_issues

  items extend: InterestInIssueRepresenter
end