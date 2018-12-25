# frozen_string_literal: true

# A patch for Raven::Context class
module Lamian::RavenContextExtension
  # Adds current lamian log to the extra part of all raven events generated inside Lamian.run block
  def extra
    extra = super || {}
    extra[:lamian_log] ||= Lamian.dump(format: :txt)
    extra
  end
end
