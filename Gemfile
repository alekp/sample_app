source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'bootstrap-sass', '2.1'
gem 'bcrypt-ruby', '3.0.1'
gem 'faker', '1.0.1' # Ch 9 http://ruby.railstutorial.org/chapters/updating-showing-and-deleting-users#code-faker_gemfile
gem 'will_paginate', '3.0.3'
gem 'bootstrap-will_paginate', '0.0.6'
gem 'jquery-rails', '2.0.2'

group :development, :test do

 gem 'sqlite3', '1.3.5'
 gem 'rspec-rails', '2.13.0'
 gem 'guard-rspec', '1.2.1'
 gem 'guard-spork', '1.2.0'
 gem 'childprocess', '0.3.9'
 gem 'spork', '0.9.2'

 gem 'watchr' # http://www.rubyinside.com/how-to-rails-3-and-rspec-2-4336.html

end

# Annotations of models Ch 6 Will add the scema ingo to the DB model 
group :development do
  gem 'annotate', '2.5.0'
end

# Gems used only for assets and not required

# in production environments by default.

group :assets do

 gem 'sass-rails',   '3.2.5'
 gem 'coffee-rails', '3.2.2'
 gem 'uglifier', '1.2.3'

end

group :test do

 gem 'capybara', '1.1.2'
 gem 'factory_girl_rails', '4.1.0' # used in test for active record Resources model creation http://ruby.railstutorial.org/chapters/sign-up#code-gemfile_factory_girl
 gem 'cucumber-rails', '1.2.1', :require => false # Ch 8 Optional 
 gem 'database_cleaner', '0.7.0'
 gem 'rb-fchange', '0.0.5'
 gem 'rb-notifu', '0.0.4'
 gem 'win32console', '1.3.0'
 # gem 'launchy', '2.1.0'
 # gem 'rb-fsevent', '0.9.1', :require => false
 # gem 'growl', '1.0.3'

end

group :production do

 gem 'pg', '0.12.2'

end