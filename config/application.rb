require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

if ['development', 'test'].include? ENV['RAILS_ENV']
  Dotenv::Railtie.load
end

module Arike
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.autoload_paths << Rails.root.join('lib')

    config.action_mailer.default_options = {
      from: ENV['MAIL_FROM_ADDRESS'],
      reply_to: ENV['MAIL_REPLY_TO_ADDRESS']
    }
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
