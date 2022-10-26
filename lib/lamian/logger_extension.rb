# frozen_string_literal: true

module Lamian
  # Provides extension to loggers, which should be teed to lamian
  module LoggerExtension
    # @api stdlib
    # Add is a single entry point for ::Logger.{debug,info,..}
    def add(...)
      Logger.current.add(...)
      super
    end

    # @api stdlib
    # log is an alis for add and should also be prepended
    def log(...)
      Logger.current.add(...)
      super
    end
  end
end
