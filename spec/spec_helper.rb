# frozen_string_literal: true

require "bundler/setup"
require "logger"
require "pry"

require "coveralls"
Coveralls.wear!

require "lamian"

shared_context "cool loggers", :cool_loggers do
  let(:generic_logger_buffer) { StringIO.new }
  let(:generic_logger) { Logger.new(generic_logger_buffer) }

  let(:cool_formatter) do
    -> (_severity, _date, _progname, message) { "#{message}\n" }
  end

  before("extend generic_logger") { Lamian.extend_logger(generic_logger) }

  before("stub formatter") do
    allow(Lamian.config).to receive(:formatter).and_return(cool_formatter)
    generic_logger.formatter = cool_formatter
  end
end
