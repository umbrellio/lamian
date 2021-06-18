# frozen_string_literal: true

describe Lamian::SidekiqSentryMiddleware, :cool_loggers do
  it "calls Sentry.set_extras and adds Lamian.run" do
    middleware_call = proc do
      Lamian::SidekiqSentryMiddleware.new.call do
        generic_logger.info "some log"
        raise "some error"
      end
    end

    expect(Sentry.get_current_scope.extra).not_to have_key(:lamian_log)
    expect(middleware_call).to raise_error(RuntimeError, "some error")
    expect(Sentry.get_current_scope.extra[:lamian_log]).to eq("some log\n")
  end
end
