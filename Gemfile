source 'https://rubygems.org'

ruby '2.4.2'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'puma', '~> 3.7'
gem 'bcrypt', '~> 3.1.7'
gem 'rack-cors'
gem 'pg'
gem 'active_model_serializers', '~> 0.10.0'

group :development, :test do
  gem 'rspec-rails'
  gem 'database_cleaner'
  gem 'awesome_print'
  gem 'pry-byebug'
  gem 'shoulda-matchers'
  gem 'factory_bot_rails'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'bundler-audit'
  gem 'brakeman'
  gem 'annotate'
end
