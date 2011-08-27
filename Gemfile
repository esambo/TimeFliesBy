source 'http://rubygems.org'

gem 'rails', '3.0.10'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3-ruby', :require => 'sqlite3'
gem 'validates_timeliness'
gem 'chronic_duration'
gem 'ruby-duration'
gem 'devise'
gem "jquery-rails"

#potential:
# gem 'chronic'
# gem 'delocalize'

group :development, :test do
  gem 'rspec-rails'
end

group :development do
  gem 'pry'
  gem 'pry-doc'
  gem 'powder'
  gem 'passenger'
  gem 'autotest-growl'   # if RUBY_PLATFORM =~ /darwin/ # Heroku push rejected
  gem 'autotest-fsevent' # if RUBY_PLATFORM =~ /darwin/ # Heroku push rejected
  gem 'heroku'
  gem 'relish', '0.4.0'
  # gem 'legacy_migrations', 
  #       :git    => 'git://github.com/btelles/legacy_migrations.git',
  #       :branch => 'rails3'
end

group :test do
  # gem 'rspec2-rails-views-matchers' #http://www.ruby-forum.com/topic/223220
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
  # gem 'mofo', :git => 'git://github.com/halfbyte/mofo.git'
  # gem 'hpricot', "~>0.8.2" #required by 'mofo'
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
