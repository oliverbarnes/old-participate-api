ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.include Helpers

  # config.before do
  #   DatabaseCleaner.start
  # end

  # config.before(:suite) do
  #   DatabaseCleaner.strategy = :truncation
  # end

  # config.after(:each) do
  #   DatabaseCleaner.clean
  # end
end
