# frozen_string_literal: true

require "sentry-ruby"

Sentry.init do |config|
  config.dsn = "dummy://public@example.com/project-id"
  config.logger = Logger.new(nil)
end
