require 'jsonapi/resource'

class AuthorResource < Base
  model_name 'Participant'

  attributes :name
end
