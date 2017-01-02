# frozen_string_literal: true
module Lamian
  # Provides extension to loggers, which should be teed to lamian
  module LoggerExtension
    # Extension to Logger#add method, which tees info into lamian
    def add(*args, &block)
      Logger.current.add(*args, &block)
      super
    end
  end
end
