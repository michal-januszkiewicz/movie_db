source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby "2.5.0"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1.5'
# Use Puma as the app server
gem 'puma', '~> 3.7'

gem "pg", "~> 1.0.0"
gem "sequel", "~> 5.5.0"
gem "rom", "~> 4.1.3"
gem "rom-model", "~> 0.5.0"
gem "rom-rails", "~> 1.0.1"
gem "rom-sql", "~> 2.4.0"

gem "envied", "~> 0.9.1"
gem "jwt", "~> 2.1.0"

gem "dry-auto_inject", "~> 0.4.5"
gem "dry-container", "~> 0.6.0"
gem "dry-validation", "~> 0.11.1"

group :development, :test do
  gem "pry-rails", "~> 0.3.6"
  gem "sanelint", "~> 1.52.1"
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem "brakeman", "~> 4.2.0"
  gem "bundler-audit", "~> 0.6.0"
end

group :test do
  gem "rspec-rails", "~> 3.7.2"
  gem "json-schema", "~> 2.8.0"
  gem "database_cleaner", "~> 1.6.2"
  gem "factory_bot", "~> 4.8.2"
  gem "faker", "~> 1.8.7"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
