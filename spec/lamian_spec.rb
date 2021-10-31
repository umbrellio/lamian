# frozen_string_literal: true

describe Lamian do
  it "has a version number" do
    expect(Lamian::VERSION).not_to be nil
  end

  describe ".dump", :cool_loggers do
    it "properly dumps logs to string" do
      Lamian.run do
        generic_logger.info "[23mNice, lol[0m"
        expect(Lamian.dump).to eq "[23mNice, lol[0m\n"
        expect(Lamian.dump(format: :text)).to eq "Nice, lol\n"
      end
    end
  end

  describe ".configure" do
    it "returns config object" do
      expect(described_class.config).to be_an_instance_of(described_class::Config)
    end

    context "with passed block" do
      it "passes config object to the block args" do
        described_class.configure do |config|
          expect(config).to be_an_instance_of(described_class::Config)
        end
      end
    end
  end
end
