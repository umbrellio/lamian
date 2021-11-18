# frozen_string_literal: true

module Lamian
  # Patch for the `Sentry::Scope`. Extends the attribute accessor
  # by adding an automatic lamian log dump.
  # You should use this patch if you want to asynchronously send events.
  # @example Prepending `Sentry::Scope` class
  #   Sentry::Scope.prepend(Lamian::SentryScopePatch) #=> Sentry::Scope
  module SentryScopePatch
    # Extra data defined in the scope.
    # @return [String]
    def extra
      log = Lamian.dump(format: :txt)&.slice(0, Lamian.config.raven_log_size_limit)
      log ? super.merge!(Lamian::SENTRY_EXTRA_KEY => log) : super
    end
  end
end
