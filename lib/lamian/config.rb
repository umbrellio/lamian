# frozen_string_literal: true

require "logger"

module Lamian
  # General lamian configuration class
  # @attr formatter [Logger::Foramtter]
  #   formatter to use in lamian, global
  # @attr sentry_log_size_limit [Integer]
  #   size limit when sending lamian log to sentry, defaults to +500_000+
  Config = Struct.new(:formatter, :sentry_log_size_limit) do
    def initialize
      self.formatter = ::Logger::Formatter.new
      self.sentry_log_size_limit = 500_000
    end
  end
end
