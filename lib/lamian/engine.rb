# frozen_string_literal: true
require 'rails'
require 'exception_notification'
require 'exception_notification/rails'

module Lamian
  # Rails engine, which injects middleware and appends
  # lamian views to rails library.
  # Lamian views are used in exception_notifier to provide
  # request_log section
  class Engine < ::Rails::Engine
    config.app_middleware.insert_before(
      ExceptionNotification::Rack,
      ::Lamian::Middleware
    )

    paths['app/views'] << 'lib/lamian/rails_views'
  end
end
