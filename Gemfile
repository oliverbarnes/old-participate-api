source 'https://rubygems.org'

gem 'bundler'

gem 'grape', github: 'oliverbarnes/grape', branch: 'mutually_exclusive'
gem 'roar'

gem 'mongoid', '~> 3.1.6', require: true
gem 'bson_ext'

group :development, :test do
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-rack'
  gem 'pry-nav'
  gem 'rspec_api_documentation'#, github: 'zipmark/rspec_api_documentation'
  gem 'raddocs'
end

group :development do
  gem 'rerun'
end

group :test do
  gem 'database_cleaner'
  gem 'rack-test'
  gem 'rspec'
  gem 'guard-rspec'
  gem 'factory_girl'
end