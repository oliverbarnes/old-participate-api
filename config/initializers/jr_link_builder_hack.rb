require 'jsonapi/resource'

module JSONAPI
  class LinkBuilder
    alias_method :original_self_link, :self_link

    def self_link(source)
      return "#{base_url}/me" if source.class._type == :me

      original_self_link(source)
    end
  end
end
