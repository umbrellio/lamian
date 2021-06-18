# frozen_string_literal: true

require "rails"

module Lamian
  # This engine is automatically loaded by Rails
  # @see https://edgeguides.rubyonrails.org/engines.html Rails::Engine docs
  class Engine < ::Rails::Engine
    # Lamian views are used in exception_notifier to provide request_log section
    paths["app/views"] << "lib/lamian/rails_views"

    initializer "lamian.use_rack_middleware" do |app|
      # :nocov:
      app.config.middleware.unshift(Lamian::Middleware)
      # :nocov:
    end

    config.after_initialize do
      # :nocov:
      next unless defined?(Sentry)
      next unless Sentry.initialized?

      Sentry.configuration.before_send = rebuild_before_send
      # :nocov:
    end

    def rebuild_before_send
      defined_callback = Sentry.configuration.before_send || build_default_lambda
      lamian_callback = build_lamian_callback

      proc { |*args, **kwargs| lamian_callback.call(defined_callback.call(*args, **kwargs)) }
    end

    def build_default_lambda
      -> (event, _hint) { event }
    end

    def build_lamian_callback
      lambda do |event|
        event.tap do |event|
          extra = event&.extra or return
          log = Lamian.dump_limited
          extra[Lamian::SENTRY_EXTRA_KEY] = log if log
        end
      end
    end
  end
end
