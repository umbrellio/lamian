# frozen_string_literal: true

# A sidekiq middleware
class Lamian::SidekiqSentryMiddleware
  # Adds current lamian log to the extra part of raven events generated inside sidekiq jobs
  def call(*)
    Lamian.run do
      yield
    rescue Exception # rubocop:disable Lint/RescueException
      # Save current log
      log = Lamian.dump_limited
      Sentry.set_extras(Lamian::SENTRY_EXTRA_KEY => log) if log
      raise
    end
  end
end
