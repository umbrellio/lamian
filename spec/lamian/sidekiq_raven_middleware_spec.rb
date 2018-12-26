# frozen_string_literal: true

describe Lamian::SidekiqRavenMiddleware, :cool_loggers do
  it "call Raven.extra_context with proper lamian_log" do
    expect(Raven).to receive(:extra_context).with(lamian_log: "some log\n")

    middleware_call = proc do
      Lamian::SidekiqRavenMiddleware.new.call do
        generic_logger.info "some log"
        raise "some error"
      end
    end

    expect(middleware_call).to raise_error(RuntimeError, "some error")
  end
end
