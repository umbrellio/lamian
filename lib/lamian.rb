# frozen_string_literal: true

module Lamian
  autoload :VERSION, 'lamian/version'

  autoload :Config, 'lamian/config'
  autoload :Logger, 'lamian/logger'
  autoload :LoggerExtension, 'lamian/logger_extension'

  class << self
    def configure
      @config ||= Config.new
      yield(@config) if block_given?
      @config
    end
    alias config configure

    def extend_logger(other_logger)
      other_logger.extend(Lamian::LoggerExtension)
    end

    def logger
      Lamian::Logger.current
    end

    def start(&block)
      logger.start(&block)
    end

    def reset
      logger.reset
    end

    def dump(&block)
      logger.dump(&block)
    end

    def stop
      logger.stop
    end
  end
end
