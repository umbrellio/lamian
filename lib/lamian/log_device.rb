# frozen_string_literal: true

module Lamian
  # @api private
  class LogDevice
    def initialize(size = Lamian.config.max_log_lines)
      self.size = size
      self.lines = []
    end

    def write(string)
      lines << string
      lines.shift if lines.size > size
      true
    end

    def string
      lines.join
    end

    private

    attr_accessor :size, :lines
  end
end
