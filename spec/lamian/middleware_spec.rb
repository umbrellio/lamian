# frozen_string_literal: true

describe Lamian::Middleware do
  let(:app) { double(:app) }
  let(:env) { double(:env) }

  it "behaves like middleware" do
    expect(app).to receive(:call).with(env)
    described_class.new(app).call(env)
  end

  it "starts lamian for app", :cool_loggers do
    expect(app).to receive(:call) do
      generic_logger.info "test"
      expect(Lamian.dump).to eq "test\n"
    end

    described_class.new(app).call(env)
  end
end
