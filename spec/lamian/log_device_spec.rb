# frozen_string_literal: true

describe Lamian::LogDevice do
  subject(:logdev) { described_class.new(max_log_lines: 5, max_log_length: 20) }

  it "saves log" do
    logdev.write("Hello\n")
    logdev.write("world!\n")
    expect(logdev.string).to eq("Hello\nworld!\n")
  end

  it "only stores 5 latest log lines" do
    8.times { |x| logdev.write(x + 1) }
    expect(logdev.string).to eq("45678")
  end

  context "long log lines" do
    it "truncates log" do
      logdev.write("Hello world, this is me!")
      expect(logdev.string).to eq("Hello world, this...")
    end

    context "line with newline in the end" do
      it "truncates log and adds newline" do
        logdev.write("Hello world, this is me!\n")
        expect(logdev.string).to eq("Hello world, thi...\n")
      end
    end
  end
end
