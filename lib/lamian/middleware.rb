# frozen_string_literal: true

module Lamian
  # Provides rack middleware, which allows to colelct request logs
  # @attr app [Proc] stored application
  class Middleware
    # @param app [Proc] stored application
    def initialize(app)
      self.app = app
    end

    # wraps application inside lamian context and calls it
    # @param env [Hash] left intact
    # @return result of app.call
    def call(env)
      Lamian.run { app.call(env) }
    end

    private

    attr_accessor :app
  end
end
