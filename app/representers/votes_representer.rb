require 'representable/json/collection'

module VotesRepresenter
  include Representable::JSON::Collection

  self.representation_wrap = :votes

  items extend: VoteRepresenter
end