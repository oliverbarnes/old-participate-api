$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'app'))

require 'grape'
require 'json'

Dir[File.expand_path('../app/api/*.rb', __FILE__)].each do |file|
  require file
end

require './api'