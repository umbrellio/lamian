# frozen_string_literal: true

module Lamian::RavenEventExtension
  def to_hash
    data = super
    data[:extra] ||= {}
    data[:extra][:lamian_log] = Lamian.dump || Thread.current[:__lamian_log]
    data
  end
end
