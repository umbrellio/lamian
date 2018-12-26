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
  end
end
