# frozen_string_literal: true
require 'logger'

module Lamian
  Config = Struct.new(:formatter) do
    def initialize
      self.formatter = ::Logger::Formatter.new
    end
  end
end
