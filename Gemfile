source :rubygems

gem 'rails', '~> 3.2.11'

platform :ruby do
  gem 'pg'
end

platform :jruby do
  gem 'activerecord-jdbc-adapter', require: false
  gem 'activerecord-jdbcpostgresql-adapter', require: false
  gem 'jdbc-postgres'
end

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
  platform :ruby do
    gem 'therubyracer'
  end
  platform :jruby do
    gem 'therubyrhino'
  end
end

group :development do
  platform :ruby do
    gem 'mailcatcher'
    gem 'foreman'
  end
  gem 'meta_request'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'capybara-email'
  gem 'capybara-webkit'
  gem 'headless'
  gem 'capybara-screenshot'
  gem 'launchy'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'simplecov'
  gem 'coveralls', require: false
  gem 'guard-rspec'
  gem 'rb-inotify'
  gem 'pry'
end

gem 'jquery-rails'
gem 'haml-rails'
gem 'bcrypt-ruby'
gem 'devise'
gem 'dynamic_form'
gem 'carrierwave'
gem 'keynote'
gem 'state_machine'
gem 'routing-filter'
gem 'http_accept_language', git: 'git://github.com/zzet/http_accept_language.git'
