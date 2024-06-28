# frozen_string_literal: true

module Lamian
  class LogDevice # :nodoc:
    def initialize(size = Lamian.config.max_log_lines)
      self.size = size
      self.lines = []
    end

    def write(string) # :nodoc:
      lines << string
      lines.shift if lines.size > size
      true
    end

    def string # :nodoc:
      lines.join
    end

    private

    attr_accessor :size, :lines
  end
end
