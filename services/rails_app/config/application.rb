require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module RailsApp
  class Application < Rails::Application
    config.load_defaults 7.1
    config.api_only = true
    config.time_zone = ENV.fetch("RAILS_TIME_ZONE", "UTC")
    config.generators.system_tests = nil

    config.cache_store = :redis_cache_store, { url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0") }
  end
end
