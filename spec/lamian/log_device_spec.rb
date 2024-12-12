# frozen_string_literal: true

describe Lamian::LogDevice do
  subject(:logdev) { described_class.new(max_log_lines: 5, max_log_length: 20) }

  it "saves log" do
    logdev.write("Hello ")
    logdev.write("world!")
    expect(logdev.string).to eq("Hello world!")
  end

  it "only stores 5 latest log lines" do
    8.times { |x| logdev.write(x + 1) }
    expect(logdev.string).to eq("45678")
  end

  it "truncates long lines" do
    logdev.write("Hello world, this is me!")
    expect(logdev.string).to eq("Hello world, this...")
  end
end
