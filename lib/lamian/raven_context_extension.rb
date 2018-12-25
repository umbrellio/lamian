# frozen_string_literal: true

# Adds current lamian log to the extra part of all raven events generated inside Lamian.run block
module Lamian::RavenContextExtension
  def extra # :nodoc:
    extra = super || {}
    extra[:lamian_log] ||= Lamian.dump(format: :txt)
    extra
  end
end
