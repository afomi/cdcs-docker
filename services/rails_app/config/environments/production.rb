require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.require_master_key = ENV["RAILS_MASTER_KEY"].present?

  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?
  config.logger = ActiveSupport::Logger.new($stdout)
  config.logger.formatter = config.log_formatter
  config.active_record.database_selector = { delay: 2.seconds }
  config.active_record.database_resolver = ActiveRecord::Middleware::DatabaseSelector::Resolver
  config.active_record.database_resolver_context = ActiveRecord::Middleware::DatabaseSelector::Resolver::Session

  config.cache_store = :redis_cache_store, { url: ENV.fetch("REDIS_URL", "redis://localhost:6379/0") }

  config.hosts = [ENV.fetch("RAILS_HOST", "rails.local"), ENV.fetch("SERVER_NAME", "")].reject(&:blank?)
  config.force_ssl = ActiveModel::Type::Boolean.new.cast(ENV.fetch("RAILS_FORCE_SSL", "false"))
end
