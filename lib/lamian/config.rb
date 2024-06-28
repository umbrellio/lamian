# frozen_string_literal: true

require "logger"

module Lamian
  # General lamian configuration class
  # @attr formatter [Logger::Foramtter]
  #   formatter to use in lamian, global
  # @attr max_log_lines [Integer]
  #   max number of log lines to log, defaults to 5000
  # @attr raven_log_size_limit [Integer]
  #   size limit when sending lamian log to sentry, defaults to +500_000+
  Config = Struct.new(:formatter, :max_log_lines, :raven_log_size_limit) do
    def initialize
      self.formatter = ::Logger::Formatter.new
      self.max_log_lines = 5000
      self.raven_log_size_limit = 500_000
    end
  end
end
