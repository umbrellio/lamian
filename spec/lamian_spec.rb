# frozen_string_literal: true
require 'spec_helper'
require 'logger'

describe Lamian do
  it 'has a version number' do
    expect(Lamian::VERSION).not_to be nil
  end

  let(:generic_logger_buffer) { StringIO.new }
  let(:generic_logger) { Logger.new(generic_logger_buffer) }

  let(:cool_formatter) do
    -> (_severity, _date, _progname ,message) { "#{message}\n" }
  end

  before('extend generic_logger') { Lamian.extend_logger(generic_logger) }

  before('stub formatter') do
    allow(Lamian.config).to receive(:formatter).and_return(cool_formatter)
    generic_logger.formatter = cool_formatter
  end

  around do |spec|
    Lamian.reset
    Lamian.stop
    spec.call
    Lamian.stop
  end

  shared_examples 'it uses separate logdev' do
    it 'uses separate logdev' do
      Lamian.start

      generic_logger.info 'before logdev separated'
      result = subject { generic_logger.info 'after lamian started' }
      generic_logger.info 'after logdev separated'

      expect(result).to eq "after lamian started\n"
      expect(Lamian.dump).to eq <<~TXT
        before logdev separated
        after logdev separated
      TXT
    end
  end

  describe '.start' do
    context 'with block' do
      it_behaves_like 'it uses separate logdev' do
        def subject
          Lamian.start { yield }
        end
      end
    end

    context 'without block' do
      it "set's up running flag" do
        generic_logger.info 'before lamian started'
        Lamian.start
        generic_logger.info 'after lamian started'

        expect(Lamian.dump).to eq "after lamian started\n"
        expect(generic_logger_buffer.string).to eq <<~TXT
          before lamian started
          after lamian started
        TXT
      end
    end
  end

  describe '.reset' do
    it 'resets logdev' do
      Lamian.start
      generic_logger.info 'before reset'
      expect(Lamian.dump).to eq "before reset\n"
      Lamian.reset
      expect(Lamian.dump).to be_empty
    end
  end

  describe '.dump' do
    context 'with block' do
      it_behaves_like 'it uses separate logdev' do
        def subject
          Lamian.dump { yield }
        end
      end
    end

    context 'without block' do
      it 'returns current logdev buffer, and it is safe to use' do
        Lamian.start
        generic_logger.info 'before dump'
        expect(Lamian.dump).to eq "before dump\n"
        Lamian.dump << 'ololo'
        expect(Lamian.dump).to eq "before dump\n"
      end
    end
  end

  describe '.stop' do
    it 'stops logging' do
      Lamian.start
      generic_logger.info 'before stop'
      result = Lamian.stop
      generic_logger.info 'after stop'
      expect(result).to eq "before stop\n"
      expect(Lamian.dump).to eq "before stop\n"
    end
  end
end
