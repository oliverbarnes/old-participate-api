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

Dir[File.expand_path('../app/representers/*.rb', __FILE__)].each do |file|
  require file
end

Dir[File.expand_path('../app/endpoints/*.rb', __FILE__)].each do |file|
  require file
end

require './api'