# frozen_string_literal: true

describe Lamian::SidekiqRavenMiddleware, :cool_loggers do
  it "call Raven.extra_context with proper lamian_log" do
    expect(Raven).to receive(:extra_context)

    middleware_call = proc do
      Lamian::SidekiqRavenMiddleware.new.call do
        raise "some error"
      end
    end

    expect(middleware_call).to raise_error(RuntimeError, "some error")
  end
end
