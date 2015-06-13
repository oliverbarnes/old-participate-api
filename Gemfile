source 'https://rubygems.org'

gem 'rails', '4.2.1'
gem 'rails-api', github: 'rails-api/rails-api'
gem 'bcrypt', '~> 3.1.7'
gem 'mongoid', '~> 4.0.0'
gem 'rack-cors', require: 'rack/cors'
gem 'httparty'
gem 'jsonapi-resources', github: 'cerebris/jsonapi-resources'

group :development, :test do
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'rspec-rails', '~> 3.0'
  gem 'guard-rspec', require: false
  gem 'guard-bundler', require: false
  gem 'guard-rubocop'
  gem 'pry'
  gem 'rubocop', require: false
  gem 'dotenv-rails'
  gem 'faker', require: false
end

group :test do
  gem 'shoulda'
  gem 'webmock', require: 'webmock/rspec'
  gem 'factory_girl_rails'
  gem 'timecop'
  gem 'json_spec'
end
