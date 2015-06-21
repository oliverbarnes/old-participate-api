require 'temp_mongoid_operations_processor'

JSONAPI.configure do |config|
  config.operations_processor = :temp_mongoid_operations_processor
end
