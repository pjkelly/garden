source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'thin'

# MongoDB
gem 'mongoid'
gem 'mongo', '1.3.1'
gem 'bson', '1.3.1'
gem 'bson_ext', '1.3.1'

gem 'json'

# Authentication
gem 'devise'

# Pagination
gem 'kaminari'

# CMS
gem 'validation_reflection'
gem 'simple_form', '2.0.0.rc'
gem 'mongoid_orderable', :git => 'git://github.com/pjkelly/mongoid_orderable.git'
gem 'inherited_resources'
gem 'redcarpet', '2.0.0b5'
gem 'mongoid_slug'
gem 'stamp'
gem 'configatron'
gem 'crushlovely_table_helper', :require => 'table_helper'
gem 'figaro'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem "sass-rails", "~> 3.2.4"
  gem "coffee-rails", "~> 3.2.2"
  gem "less-rails", "~> 2.1.5"
  gem "uglifier", "~> 1.2.3"
  gem "compass-rails", "~> 1.0.0"
  gem 'bootstrap-sass'
end

gem 'jquery-rails'

# Test suite
group :development, :test, :spec do
  gem 'foreman'
  # rspec-rails, rspec, and capybara
  # are implicit when requiring this
  gem 'steak'
  gem 'guard'
  gem 'growl'
  gem 'guard-bundler'
  gem 'guard-rspec'
  gem 'fuubar'
  gem 'rb-fsevent', :require => false
  gem 'simplecov'
  gem 'ffaker'
end

group :test, :spec do
  gem 'database_cleaner'
  gem 'delorean'
  gem 'factory_girl_rails'
  # This revision includes support for spec'ing document indexes.
  gem 'mongoid-rspec', :git => 'git://github.com/evansagge/mongoid-rspec.git', :ref => 'c6e4ca867788fcb4678e46dec64961e8835780e4'
  gem 'email_spec'
end
