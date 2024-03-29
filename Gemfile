source "https://rubygems.org"

ruby "3.2.2"

gem "rails", "~> 7.1.3"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails", "~> 2.0.2"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "jbuilder"
gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

gem "view_component"
gem "view_component-form"

gem "passwordless"

gem "action_policy"
gem "propshaft", "~> 0.8.0"

gem "freezolite" # Freezolite add frozen_string_literals to true to every file in your project
gem "anycable-rails", "~> 1.4"
gem "anycable-rails-jwt", "~> 0.2.0"
gem "anyway_config", "~> 2.0"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri windows]
  gem "nokogiri"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
  gem "hotwire-livereload"
  gem "rspec-rails"
  gem "rubocop-rspec"
  gem "standard"
  gem "standard-rails"
  gem "lookbook", ">= 2.1.1"
  gem "listen"
  gem "solargraph"
  gem "solargraph-rails"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "cuprite"
  gem "test-prof"
  gem "factory_bot_rails"
  gem "shoulda-matchers"
end
