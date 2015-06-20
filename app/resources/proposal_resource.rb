require 'jsonapi/resource'

class ProposalResource < JSONAPI::Resource
  attributes :title, :body

  class << self
    # So JR accepts mongo ids
    def verify_key(key, _context = nil)
      key && String(key)
    end
  end
end
