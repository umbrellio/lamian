# frozen_string_literal: true

describe Lamian::LogDevice do
  subject(:logdev) { described_class.new(10) }

  it "saves log" do
    logdev.write("Hello ")
    logdev.write("world!")
    expect(logdev.string).to eq("Hello world!")
  end

  it "limits log lines" do
    15.times { logdev.write("hello") }
    expect(logdev.string.scan(/hello/).size).to eq(10)
  end
end
