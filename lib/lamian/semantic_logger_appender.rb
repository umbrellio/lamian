# frozen_string_literal: true

module Lamian
  # Custom appender for the `semantic_logger` library.
  # This appender adds all logs to the current Lamian logger.
  # Since Lamian stores logs in a thread variable,
  # it is necessary that this appender writes logs synchronously:
  # just call `SematicLogger.sync!` somewhere in the initialization process.
  # @see https://logger.rocketjob.io Semantic Logger documentation.
  class SemanticLoggerAppender < SemanticLogger::Subscriber
    # Mapping between standard Logger severity and SemanticLogger log levels.
    LOGGER_LEVELS_MAPPING = { trace: 0, debug: 0, info: 1, warn: 2, error: 3, fatal: 4 }.freeze

    # The method to be implemented when creating a custom appender.
    # @see https://logger.rocketjob.io/custom_appenders.html Documentation about custom appenders.
    # @returns [Boolean]
    def log(log)
      mapped_level = LOGGER_LEVELS_MAPPING[log.level] || ::Logger::UNKNOWN
      Lamian::Logger.current.add(mapped_level, log.message)

      true
    end
  end
end
