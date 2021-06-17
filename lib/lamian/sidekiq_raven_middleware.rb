# frozen_string_literal: true

# A sidekiq middleware
class Lamian::SidekiqRavenMiddleware
  # Adds current lamian log to the extra part of raven events generated inside sidekiq jobs
  def call(*)
    Lamian.run do
      yield
    rescue Exception # rubocop:disable Lint/RescueException
      Raven.extra_context # Just trigger saving of the current log
      raise
    end
  end
end
