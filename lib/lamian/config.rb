# frozen_string_literal: true

module Lamian
  # General lamian configuration class
  # @attr formatter [Logger::Foramtter]
  #   formatter to use in lamian, global
  # @attr max_log_lines [Integer]
  #   max number of most recent log lines to store, defaults to 5000
  # @attr raven_log_size_limit [Integer]
  #   size limit when sending lamian log to sentry, defaults to +500_000+
  # @attr middleware_autoset [BOolean]
  #   automatically setup a middleware module during rails initialization process
  Config = Struct.new(
    :formatter,
    :max_log_lines,
    :raven_log_size_limit,
    :middleware_autoset,
  ) do
    def initialize
      self.formatter = ::Logger::Formatter.new
      self.max_log_lines = 5000
      self.raven_log_size_limit = 500_000
      self.middleware_autoset = true
    end
  end
end
