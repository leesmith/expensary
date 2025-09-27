source "https://rubygems.org"

ruby File.read(".ruby-version").strip

gem "bcrypt"
gem "bootsnap", require: false
gem "csv"
gem "importmap-rails"
gem "jbuilder"
gem "propshaft"
gem "puma"
gem "rails"
gem "rails_heroicon"
gem "sqlite3"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "turbo-rails"

group :development, :test do
  gem "amazing_print"
  gem "brakeman", require: false
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "factory_bot_rails"
  gem "faker"
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "better_errors"
  gem "binding_of_caller"
end

group :test do
  gem "capybara"
  gem "shoulda-context"
  gem "shoulda-matchers"
  gem "selenium-webdriver"
end
