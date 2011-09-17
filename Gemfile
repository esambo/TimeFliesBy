source 'http://rubygems.org'

gem 'rails', '3.1.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'validates_timeliness'
gem 'chronic_duration'
gem 'ruby-duration'
gem 'devise'
gem 'thin'

#potential:
# gem 'chronic'
# gem 'delocalize'


group :development, :test do
  gem 'rspec-rails'
  gem 'sqlite3'
end

group :development do
  gem 'pry'
  gem 'pry-doc'
  gem 'powder'
  gem 'passenger'
  gem 'autotest-growl'   # if RUBY_PLATFORM =~ /darwin/ # Heroku push rejected
  gem 'autotest-fsevent' # if RUBY_PLATFORM =~ /darwin/ # Heroku push rejected
  # gem 'relish', '0.5.1' #has old dependencies on json '~> 1.4.6' which excludes '1.6.0'
  gem 'heroku'
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

group :production do
  gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

