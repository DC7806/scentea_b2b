# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'jbuilder', '~> 2.7'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.3.5'
gem 'rails', '~> 6.0.3.3'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 5.1.1'

gem 'acts_as_list', '~> 1.0.1'
gem 'aws-sdk-s3', '~> 1.77.0'
gem 'devise', '~> 4.7.1'
gem 'image_processing', '~> 1.11.0'
gem 'kaminari', '~> 1.2.1'
gem 'mailgun-ruby', '~> 1.2'
gem 'meta-tags', '~> 2.13.0'
gem 'mobility', '~> 0.8.13'
gem 'ransack', '~> 2.3.2'
gem 'shrine', '~> 3.3.0'
gem 'sidekiq', '~> 6.1.1'
gem 'simple_form', '~> 5.0.2'
gem 'slim', '~> 4.0.1'
gem 'strong_migrations', '~> 0.6.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails', '~> 2.7.5'
  gem 'factory_bot_rails', '~> 5.1.1'
  gem 'faker', '~> 2.11'
  gem 'rubocop', '~> 0.80.1', require: false
  gem 'rubocop-performance', '~> 1.5.2'
  gem 'rubocop-rails', '~> 2.5'
end

group :development do
  gem 'annotate', '~> 3.0.3'
  gem 'bullet', '~> 6.1'
  gem 'capistrano',         require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-rbenv',   require: false
  gem 'capistrano-yarn',    require: false
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'capybara', '~> 3.31.0'
  gem 'database_cleaner', '~> 1.8.3'
  gem 'rspec-rails', '~> 4.0'
  gem 'shoulda-matchers', '~> 4.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
