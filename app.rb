$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))

require 'rubygems'
require 'bundler'
require 'bundler/setup'

Bundler.require :default, ENV['RACK_ENV']

require 'grape'
require 'json'
require 'mongoid'

I18n.enforce_available_locales = false

Mongoid.load!('config/mongoid.yml', ENV['RACK_ENV'])

Dir[File.expand_path('../app/models/*.rb', __FILE__)].each do |file|
  require file
end

#11.07.2014 hack to get around non-alphebetical listing of rb files
require_relative "app/representers/area_membership_representer.rb"
require_relative "app/representers/area_memberships_representer.rb"
require_relative "app/representers/area_representer.rb"
require_relative "app/representers/areas_representer.rb"
require_relative "app/representers/delegation_representer.rb"
require_relative "app/representers/delegations_representer.rb"
require_relative "app/representers/initiative_representer.rb"
require_relative "app/representers/initiatives_representer.rb"
require_relative "app/representers/interest_in_issue_representer.rb"
require_relative "app/representers/interests_in_issues_representer.rb"
require_relative "app/representers/issue_representer.rb"
require_relative "app/representers/issues_representer.rb"
require_relative "app/representers/suggestion_to_initiative_representer.rb"
require_relative "app/representers/suggestions_to_initiatives_representer.rb"
require_relative "app/representers/support_to_initiative_representer.rb"
require_relative "app/representers/supports_to_initiatives_representer.rb"
require_relative "app/representers/vote_representer.rb"
require_relative "app/representers/votes_representer.rb" 

#Dir[File.expand_path('../app/representers/*.rb', __FILE__)].each do |file|
#  require file
#end

Dir[File.expand_path('../app/endpoints/*.rb', __FILE__)].each do |file|
  require file
end

require './api'
