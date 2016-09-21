# frozen_string_literal: true
module Lamian
  class Middleware
    def initialize(app)
      self.app = app
    end

    def call(env)
      Lamian.run { app.call(env) }
    end

    private

    attr_accessor :app
  end
end
