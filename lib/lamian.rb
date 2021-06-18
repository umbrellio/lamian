# frozen_string_literal: true

# Lamian is an in-memory logger, which content could be released
# for error messages.
# It is designed to work in pair with `exception_notification` gem inside
# rails aplications
module Lamian
  autoload :VERSION, "lamian/version"
  autoload :Config, "lamian/config"
  autoload :Logger, "lamian/logger"
  autoload :LoggerExtension, "lamian/logger_extension"
  autoload :Middleware, "lamian/middleware"
  autoload :RavenContextExtension, "lamian/raven_context_extension"
  autoload :SidekiqRavenMiddleware, "lamian/sidekiq_raven_middleware"
  autoload :SidekiqSentryMiddleware, "lamian/sidekiq_sentry_middleware"

  SENTRY_EXTRA_KEY = :lamian_log

  require "lamian/engine"

  class << self
    # Yields curent configuration if block given
    # @example
    #   Lamian.configure do |config|
    #     config.formatter = MyFormatter.new
    #   end
    # @yield [config] current configuration
    # @yieldparam config [Lamian::Config]
    # @return [Lamian::Config] current configuration
    def configure
      @config ||= Config.new
      yield(@config) if block_given?
      @config
    end
    alias config configure

    # Extends logger instance to tee it's output to Lamian logger
    # @param other_logger [Logger] logger to extend
    def extend_logger(other_logger)
      other_logger.extend(Lamian::LoggerExtension)
    end

    # @api private
    # Gives access to current logger
    # @return [Lamian::Logger] current logger
    def logger
      Lamian::Logger.current
    end

    # Collects logs sent inside block
    def run(&block)
      logger.run(&block)
    end

    # Dumps log collected in this run
    # @param format [Symbol]
    #   requested format of log. At this point, returns raw log if falsey
    #   or log without controll sequences (such as '[23m') if truthy
    #   value given (for now)
    # @return formatted log (String by default)
    def dump(format: nil)
      logger.dump(format: format)
    end

    # Truncates the collected log to the specified limit and dumps it.
    # @return [String, nil] truncated formatted log.
    def dump_limited
      dump(format: :txt)&.slice(0, Lamian.config.raven_log_size_limit)
    end
  end
end
