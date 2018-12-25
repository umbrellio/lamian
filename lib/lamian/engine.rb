# frozen_string_literal: true

require "rails"

module Lamian
  class Engine < ::Rails::Engine
    # Lamian views are used in exception_notifier to provide request_log section
    paths["app/views"] << "lib/lamian/rails_views"

    initializer "lamian.use_rack_middleware" do |app|
      app.config.middleware.unshift(Lamian::Middleware)
    end

    initializer "lamian.patch_raven_context" do
      return unless defined?(Raven::Context)
      Raven::Context.prepend(Lamian::RavenContextExtension)
    end
  end
end
