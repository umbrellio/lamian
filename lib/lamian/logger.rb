# frozen_string_literal: true

require 'logger'

module Lamian
  class Logger < ::Logger
    def self.current
      Thread.current[:__lamian_logger] ||= new
    end

    def initialize(running = false)
      self.running = running
      self.level = 0
      reset
    end

    def start
      if block_given?
        run_with_separate_logdev { yield }
      else
        reset
        self.running = true
      end
    end

    def reset
      self.logdev = StringIO.new
    end

    def dump(format: nil)
      result = block_given? ? run_with_separate_logdev { yield } : logdev.string.dup
      format ? prepare_output(format, result) : result
    end

    def stop
      self.running = false
      dump
    end

    def add(*)
      return unless running?
      self.formatter = Lamian.config.formatter
      super
    end

    private

    def prepare_output(_format, text)
      text.gsub!(/\[\d{1,2}m/, '')
      text
    end

    attr_accessor :running, :logdev, :level, :formatter
    alias running? running

    def run_with_separate_logdev
      old_logdev = logdev
      old_running = running?
      start
      yield
      stop
    ensure
      self.logdev = old_logdev
      self.running = old_running
    end
  end
end
