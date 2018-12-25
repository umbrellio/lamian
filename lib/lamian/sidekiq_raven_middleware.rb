# frozen_string_literal: true

# Adds current lamian log to the extra part of raven events generated inside sidekiq jobs
class Lamian::SidekiqRavenMiddleware
  def call(*)
    Lamian.run do
      begin
        yield
      rescue
        Raven.extra_context(lamian_log: Lamian.dump(format: :txt))
        raise
      end
    end
  end
end
