require 'rubygems'

ENV["RACK_ENV"] ||= 'test'

require 'rack/test'
require './app'