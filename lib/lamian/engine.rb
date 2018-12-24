# frozen_string_literal: true

require "rails"

module Lamian
  class Engine < ::Rails::Engine
    def self.patch_active_job!
      return unless defined?(ActiveJob::Base)
      ActiveJob::Base.include(Lamian::ActiveJobExtension)
    end

    def self.patch_raven_event!
      return unless defined?(Raven::Event)
      Raven::Event.prepend(Lamian::RavenEventExtension)
    end

    # Lamian views are used in exception_notifier to provide request_log section
    paths["app/views"] << "lib/lamian/rails_views"

    initializer "lamian.use_rack_middleware" do |app|
      app.config.middleware.unshift(Lamian::Middleware)
    end

    initializer "lamian.path_active_job" do
      self.class.patch_active_job!
    end

    initializer "lamian.patch_raven_event" do
      self.class.patch_raven_event!
    end
  end
end
