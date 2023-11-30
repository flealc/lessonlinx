require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsTemplate
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = "UTC"
    # config.eager_load_paths << Rails.root.join("extras")
    config.generators do |g|
      g.test_framework nil
      g.factory_bot false
      g.scaffold_stylesheet false
      g.stylesheets false
      g.javascripts false
      g.helper false
      g.orm :active_record, primary_key_type: :uuid # add uuids for primary keys
    end

    config.action_controller.default_protect_from_forgery = false
    config.generators.system_tests = nil

    # Configure ActiveJob to use good_job
    config.active_job.queue_adapter = :good_job

    # Configure Postmark
    config.action_mailer.delivery_method = :postmark

    config.action_mailer.postmark_settings = {
      api_token: Rails.application.credentials.postmark_api_token,
    }
  end
end
