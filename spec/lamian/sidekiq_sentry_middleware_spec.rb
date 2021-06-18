# frozen_string_literal: true

describe Lamian::SidekiqSentryMiddleware, :cool_loggers do
  around do |example|
    Sentry.with_scope { example.call }
  end

  let(:middleware_call) do
    proc do
      Lamian::SidekiqSentryMiddleware.new.call do
        generic_logger.info "some log"
        raise "some error"
      end
    end
  end

  it "calls Sentry.set_extras and adds Lamian.run" do
    expect(Sentry.get_current_scope.extra).not_to include(:lamian_log)
    expect(middleware_call).to raise_error(RuntimeError, "some error")
    expect(Sentry.get_current_scope.extra[:lamian_log]).to eq("some log\n")
  end

  context "without logs" do
    before { allow(Lamian).to receive(:dump_limited).and_return(nil) }

    it "doesn't set extras" do
      expect(Sentry.get_current_scope.extra).not_to include(:lamian_log)
      expect(middleware_call).to raise_error(RuntimeError, "some error")
      expect(Sentry.get_current_scope.extra).not_to include(:lamian_log)
    end
  end
end
