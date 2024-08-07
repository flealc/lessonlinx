source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.1"

gem "bootsnap", require: false
gem "good_job"
gem "icalendar"
gem "importmap-rails"
gem "jbuilder"
gem "meta-tags"
gem "pg", "~> 1.1"
gem "postmark-rails"
gem "puma", "~> 5.0"
gem "pundit"
gem "rails", "~> 7.0.4", ">= 7.0.4.3"
gem "rails_admin", "~> 3.1"
gem "rails_db"
gem "ransack"
gem "redis", "~> 4.0"
gem "sassc-rails"
gem "sentry-rails", "~> 5.13"
gem "sentry-ruby", "~> 5.13"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# AppDev Gems
# ===========
gem "appdev_support"
gem "awesome_print"
gem "devise"       
gem "dotenv-rails"
gem "faker"
gem "htmlbeautifier"
gem "http"
gem "table_print"


group :development do
  gem "annotate"
  gem "better_errors"
  gem "binding_of_caller"
  gem "draft_generators"
  gem "dockerfile-rails", ">= 1.5"
  gem "grade_runner"
  gem "pry-rails"
  gem "rails-erd"
  gem "rufo"
  gem "specs_to_readme"
  gem "web_git"
  gem "letter_opener"
  gem "web-console"
  gem "whenever", require: false
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "draft_matchers"
  gem "rspec-html-matchers"
  gem "webmock"
end

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "rspec-rails", "~> 6.0.0"
end
