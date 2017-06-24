# frozen_string_literal: true

require 'logger'

module Lamian
  # General lamian configuration class
  # @attr formatter [Logger::Foramtter]
  #   formatter to use in lamian, global
  Config = Struct.new(:formatter) do
    def initialize
      self.formatter = ::Logger::Formatter.new
    end
  end
end
