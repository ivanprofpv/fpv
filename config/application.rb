require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Fpv
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0
    config.active_storage.variant_processor = :vips

    config.exceptions_app = self.routes

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    config.time_zone = 'Moscow'

    config.active_job.queue_adapter = :sidekiq

    config.action_cable.disable_request_forgery_protection = false

    config.middleware.use Warden::Manager

    config.eager_load_paths.reject! { |path| path == Rails.root.join("app", "indices").to_s }

    config.generators do |g|
      g.test_framework :rspec,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       controller_specs: true,
                       request_specs: false
    end
  end
end
