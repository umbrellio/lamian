# frozen_string_literal: true

describe Lamian::SentryScopePatch, :cool_loggers do
  around do |example|
    original_scope = Sentry.get_current_hub.send(:current_layer).scope
    prepended_scope = Sentry::Scope.new.tap do |scope|
      scope.singleton_class.prepend(Lamian::SentryScopePatch)
    end
    Sentry.get_current_hub.send(:current_layer).instance_variable_set(:@scope, prepended_scope)

    example.run

    Sentry.get_current_hub.send(:current_layer).instance_variable_set(:@scope, original_scope)
  end

  before do
    allow(Sentry.get_current_client).to receive(:send_event) do |event, _|
      sent_events << event
    end
  end

  let(:sent_events) { [] }

  it "properly set lamian log to extra info" do
    Lamian.run do
      generic_logger.info "some log"
      Sentry.capture_message("msg")
    end

    expect(sent_events.size).to eq(1)
    expect(sent_events.first.extra).to include(lamian_log: "some log\n")
  end

  context "with empty lamian log" do
    it "skips log dumping" do
      Sentry.capture_message("msg")

      expect(sent_events.size).to eq(1)
      expect(sent_events.first.extra).not_to include(:lamian_log)
    end
  end
end
