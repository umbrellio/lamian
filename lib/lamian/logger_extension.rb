# frozen_string_literal: true

module Lamian
  # Provides extension to loggers, which should be teed to lamian
  module LoggerExtension
    # @api stdlib
    # Add is a single entry point for ::Logger.{debug,info,..}
    def add(*args, &block)
      Logger.current.add(*args, &block)
      super
    end

    # @api stdlib
    # log is an alis for add and should also be prepended
    def log(*args, &block)
      Logger.current.add(*args, &block)
      super
    end
  end
end
