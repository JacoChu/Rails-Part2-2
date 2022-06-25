require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Part22
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.i18n.default_locale = "zh-CN"
    config.time_zone = "Taipei"
    config.action_view.sanitized_allowed_tags = Rails::Html::WhiteListSanitizer.allowed_tags + %w(table tr td)
    config.action_view.sanitized_allowed_attributes = Rails::Html::WhiteListSanitizer.allowed_attributes + %w(style border)

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    Time::DATE_FORMATS.merge!(default:'%Y/%m/%d %I:%M %p', ymd: '%Y/%m/%d')

  end
end
