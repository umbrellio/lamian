# frozen_string_literal: true

module Lamian::RavenContextExtension
  def extra
    extra = super || {}
    extra[:lamian_log] ||= Lamian.dump(format: :txt)
    extra
  end
end
