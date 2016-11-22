# frozen_string_literal: true

require 'logger'

module Lamian
  class Logger < ::Logger
    def self.current
      Thread.current[:__lamian_logger] ||= new
    end

    def initialize
      self.level = 0
      self.logdevs = []
      self.formatter = Lamian.config.formatter
    end

    def run
      push_logdev(StringIO.new)
      yield
    ensure
      pop_logdev
    end

    def add(*args, &block)
      each_logdev { super(*args, &block) }
    end

    def dump(format: nil)
      result = logdevs[-1]&.string&.dup
      apply_format!(format, result)
      result
    end

    private

    attr_accessor :level, :logdevs, :formatter

    def apply_format!(format, result)
      return unless format
      return unless result
      result.gsub!(/\[\d{1,2}m/, '')
    end

    def push_logdev(logdev)
      logdevs << logdev
    end

    def pop_logdev
      logdevs.pop
    end

    def each_logdev
      logdevs.each do |logdev|
        @logdev = logdev
        yield
      end
    end
  end
end
