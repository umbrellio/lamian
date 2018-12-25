# frozen_string_literal: true

require "rails"

module Lamian
  # See Rails::Engine docs
  class Engine < ::Rails::Engine
    # Lamian views are used in exception_notifier to provide request_log section
    paths["app/views"] << "lib/lamian/rails_views"

    initializer "lamian.use_rack_middleware" do |app|
      app.config.middleware.unshift(Lamian::Middleware)
    end
  end
end
