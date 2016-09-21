require 'rails'
require 'exception_notification'
require 'exception_notification/rails'

module Lamian
  class Engine < ::Rails::Engine
    config.app_middleware.insert_before(
      ExceptionNotification::Rack,
      ::Lamian::Middleware
    )

    paths['app/views'] << 'lib/lamian/rails_views'
  end
end
