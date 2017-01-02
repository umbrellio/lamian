# frozen_string_literal: true

require 'logger'

module Lamian
  # @api private
  # Provides thread-local loggers to catch teed messages from
  # regular loggers.
  # Uses :__lamian_logger thread variable
  # @attr level [Int]
  #   current log level, implicitly set to zero
  # @attr logdevs [Array(StringIO)]
  #   stack of log devices used to store logs
  # @attr formatter [Logger::Formatter]
  #   formatter, inherited from Lamian.config
  class Logger < ::Logger
    # Provides access to logger bound to curent thread
    # @return [Lamian::Logger] current logger
    def self.current
      Thread.current[:__lamian_logger] ||= new
    end

    def initialize
      self.level = 0
      self.logdevs = []
      self.formatter = Lamian.config.formatter
    end

    # @see Lamian.run
    # Collects logs sent inside block
    def run
      push_logdev(StringIO.new)
      yield
    ensure
      pop_logdev
    end

    # Part of Logger api, entry point for all logs
    # extened to run on each log device in stack
    def add(*args, &block)
      each_logdev { super(*args, &block) }
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

    attr_accessor :level, :logdevs, :formatter

    # Formats string using given format
    # @param format [Symbol] request format, e.g. :text, :html
    # @param string [String] string to be changed
    # @return avoid return value usage
    def apply_format!(format, string)
      return unless format
      return unless string
      string.gsub!(/\[\d{1,2}m/, '')
    end

    # Pushes new logdev in the start of #run call
    # @param logdev [StringIO] new StringIO
    def push_logdev(logdev)
      logdevs << logdev
    end

    # Pops logdev in the end of #run call
    # @return [StringIO] logdev
    def pop_logdev
      logdevs.pop
    end

    # Runs specific block with all logdevs in stack to
    # populate them all
    def each_logdev
      logdevs.each do |logdev|
        @logdev = logdev
        yield
      end
    end
  end
end
