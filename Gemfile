source 'https://rubygems.org'

gem 'rails', '4.2.1'
gem 'rails-api', github: 'rails-api/rails-api'
gem 'figaro'
gem 'bcrypt', '~> 3.1.7'
gem 'mongoid', '~> 4.0.2'
gem 'moped'
gem 'rack-cors', '~> 0.4.0', require: 'rack/cors'
gem 'httparty'
gem 'jsonapi-resources', github: 'cerebris/jsonapi-resources', branch: 'whitelist_controller_exceptions'
gem 'jwt'

group :development, :test do
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'rspec-rails', '~> 3.0'
  gem 'guard-rspec', require: false
  gem 'guard-bundler', require: false
  gem 'guard-rubocop'
  gem 'pry', github: 'pry/pry'
  gem 'rubocop', require: false
  gem 'faker', require: false
  gem 'database_cleaner', '~> 1.4.1'
end

group :test do
  gem 'webmock', require: 'webmock/rspec'
  gem 'factory_girl_rails'
  gem 'json_spec'
end
