source 'http://rubygems.org'

gem 'rails', '3.0.3'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3-ruby', :require => 'sqlite3'
gem 'validates_timeliness'
gem 'chronic_duration'
gem 'devise'

#potential:
# gem 'chronic'
# gem 'delocalize'


group :development do
  gem "rspec-rails", "~> 2.4"
  gem 'passenger'
  gem 'autotest-growl'   if RUBY_PLATFORM =~ /darwin/
  gem 'autotest-fsevent' if RUBY_PLATFORM =~ /darwin/
  gem 'heroku'
  # gem 'legacy_migrations', 
  #       :git    => 'git://github.com/btelles/legacy_migrations.git',
  #       :branch => 'rails3'
end

group :test do
  gem "rspec-rails", "~> 2.4"
  gem 'cucumber-rails'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'spork'
  gem 'autotest'
  gem 'time_travel'
  gem 'syntax'
  gem 'ruby-debug-base19'
  gem 'ruby-debug-ide'
end

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end
