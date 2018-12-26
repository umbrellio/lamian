# frozen_string_literal: true

require "raven"
require "raven/transports/dummy"

Raven::Context.prepend(Lamian::RavenContextExtension)

Raven.configure do |config|
  config.dsn = "dummy://public@example.com/project-id"
  config.encoding = "json"
  config.logger = Logger.new(nil)
end

describe Lamian::RavenContextExtension, :cool_loggers do
  after { sent_events.clear }

  let(:sent_events) { Raven.client.transport.events }
  let(:extra_info) { JSON.parse(sent_events.last[1]).fetch("extra") }

  it "adds current lamian log to event" do
    Lamian.run do
      generic_logger.info "some log"
      Raven.capture_message("msg")
    end

    expect(extra_info["lamian_log"]).to eq("some log\n")
  end

  context "outside of Lamian.run block" do
    it "doesn't add lamian log" do
      Raven.capture_message("msg")
      expect(extra_info).not_to have_key("lamian_log")
    end
  end
end
