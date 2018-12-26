# frozen_string_literal: true

describe Lamian::SidekiqRavenMiddleware, :cool_loggers do
  it "calls Raven.extra_context and adds Lamian.run" do
    middleware_call = proc do
      Lamian::SidekiqRavenMiddleware.new.call do
        generic_logger.info "some log"
        raise "some error"
      end
    end

    expect(Raven.extra_context).not_to have_key(:lamian_log)
    expect(middleware_call).to raise_error(RuntimeError, "some error")
    expect(Raven.extra_context[:lamian_log]).to eq("some log\n")
  end
end
