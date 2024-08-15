# frozen_string_literal: true

require "logger"

module Lamian
  # @api private
  # Provides thread-local loggers to catch teed messages from
  # regular loggers.
  # Uses :__lamian_logger thread variable
  class Logger < ::Logger
    # Provides access to logger bound to curent thread
    # @return [Lamian::Logger] current logger
    def self.current
      Thread.current[:__lamian_logger] ||= new
    end

    def initialize
      super(nil)
      self.level = 0
      self.logdevs = []
    end

    # @see Lamian.run
    # Collects logs sent inside block
    def run
      logdevs.push(Lamian::LogDevice.new)
      yield
    ensure
      logdevs.pop
    end

    # Part of Logger api, entry point for all logs
    # extened to run on each log device in stack
    def add(*args, &)
      @formatter = Lamian.config.formatter

      logdevs.each do |logdev|
        @logdev = logdev
        super
      end
    end

    # @see Lamian.dump
    # Dumps log collected in this run
    # @option format [Symbol]
    #   requested format of log. At this point, returns raw log if falsey
    #   or log without controll sequences (such as '[23m') if truthy
    #   value given (for now)
    # @return formatted log (String by default)
    def dump(format: nil)
      result = logdevs[-1]&.string&.dup
      apply_format!(format, result)
      result
    end

    private

    # @return [Int]
    #   current log level, implicitly set to zero
    attr_accessor :level

    # @return [Array(StringIO)]
    #   stack of log devices used to store logs
    attr_accessor :logdevs

    # Formats string using given format
    # @todo create `formatters` interface to allow real format selection
    # @note
    #   `format` is now checked only for thruthyness. Please, use
    #   `:text` format to keep it same after `formatters` interface integration
    # @param format [Symbol] requested format, e.g. `:text`
    # @param string [String] string to be changed
    # @return avoid return value usage
    def apply_format!(format, string)
      return unless format
      return unless string
      string.gsub!(/\[\d{1,2}m/, "")
    end
  end
end
