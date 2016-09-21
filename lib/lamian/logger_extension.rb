# frozen_string_literal: true
module Lamian
  module LoggerExtension
    def add(*args, &block)
      Logger.current.add(*args, &block)
      super
    end
  end
end
