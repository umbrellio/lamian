# frozen_string_literal: true

module Lamian
  class LogDevice # :nodoc:
    def initialize(max_log_lines: Lamian.config.max_log_lines,
                   max_log_length: Lamian.config.max_log_length)
      self.max_log_lines = max_log_lines
      self.max_log_length = max_log_length
      self.lines = []
    end

    def write(msg) # :nodoc:
      lines << truncate(msg)
      lines.shift if lines.size > max_log_lines
      true
    end

    def string # :nodoc:
      lines.join
    end

    private

    attr_accessor :lines, :max_log_lines, :max_log_length

    def truncate(msg) # :nodoc:
      return msg unless msg.size > max_log_length

      suffix = +"..."
      suffix << "\n" if msg.end_with?("\n")
      msg = msg[0, max_log_length - suffix.size]

      "#{msg}#{suffix}"
    end
  end
end
