# frozen_string_literal: true

# A patch for Raven::Context class
module Lamian::RavenContextExtension
  # Adds current lamian log to the extra part of all raven events generated inside Lamian.run block
  # @see https://www.rubydoc.info/gems/sentry-raven/0.9.2/Raven/Context#extra-instance_method
  def extra
    log = Lamian.dump_limited
    log ? super.merge!(Lamian::SENTRY_EXTRA_KEY => log) : super
  end
end
