# frozen_string_literal: true

require "raven"
require "raven/transports/dummy"

Raven::Context.prepend(Lamian::RavenContextExtension)

Raven.configure do |config|
  config.dsn = "dummy://public@example.com/project-id"
  config.encoding = "json"
  config.logger = Logger.new(nil)
end
