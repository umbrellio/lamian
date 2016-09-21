module Lamian
  class Middleware
    def initialize(app)
      self.app = app
    end

    def call(env)
      result = []
      Lamian.start { result = app.call(env) }
      result
    end

    private

    attr_accessor :app
  end
end
