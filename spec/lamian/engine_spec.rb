# frozen_string_literal: true

describe Lamian::Engine, :cool_loggers do
  subject(:instance) { described_class.instance }

  describe ".rebuild_before_send" do
    let(:stubbed_event) do
      instance_double(Sentry::Event).tap do |event|
        allow(event).to receive(:extra).and_return(extra_hash)
      end
    end
    let(:extra_hash) { Hash[] }

    let(:callback) { instance.rebuild_before_send }

    it "properly sets lamian_log" do
      event = Lamian.run do
        generic_logger.info "some log"
        callback.call(stubbed_event, {})
      end

      expect(extra_hash).to include(:lamian_log)
      expect(event).not_to eq(nil)
    end

    context "without logs" do
      before { allow(Lamian).to receive(:dump_limited).and_return(nil) }

      it "doesn't set lamian log" do
        callback.call(stubbed_event, {})

        expect(extra_hash).not_to include(:lamian_log)
      end
    end

    context "when event is not returned" do
      it "doesn't set lamian log" do
        result = Lamian.run do
          generic_logger.info "some log"
          callback.call(nil, {})
        end

        expect(result).to eq(nil)
        expect(extra_hash).not_to include(:lamian_log)
      end
    end
  end
end
