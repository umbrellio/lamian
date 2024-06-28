# frozen_string_literal: true

describe Lamian::SemanticLoggerAppender, :cool_loggers do
  subject(:appender) { described_class.new }

  let(:cool_formatter) do
    -> (severity, _date, _progname, message) { "[#{severity}] #{message}\n" }
  end

  let(:log) do
    instance_double(SemanticLogger::Log).tap do |instance|
      allow(instance).to receive_messages(message: "some message", level: log_level)
    end
  end
  let(:log_level) { :debug }

  it "properly adds logs to Lamian" do
    Lamian.run do
      expect(appender.log(log)).to eq(true)
      expect(Lamian.dump).to eq("[DEBUG] some message\n")
    end
  end

  context "with unknown log level" do
    let(:log_level) { :custom_level }

    it "uses UNKNOWN severity" do
      Lamian.run do
        expect(appender.log(log)).to eq(true)
        expect(Lamian.dump).to eq("[ANY] some message\n")
      end
    end
  end
end
