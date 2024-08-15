# frozen_string_literal: true

require "bundler/setup"
require "pry"
require "semantic_logger"

require "simplecov"
require "simplecov-lcov"

SimpleCov::Formatter::LcovFormatter.config do |config|
  config.report_with_single_file = true
  config.lcov_file_name = "lcov.info"
  config.output_directory = "coverage"
end

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::LcovFormatter,
])

SimpleCov.start do
  enable_coverage :branch
  minimum_coverage(line: 100, branch: 92.85) if ENV["FULL_COVERAGE_CHECK"] == "true"
  add_filter "spec"
end

require "lamian"

Dir[File.join(__dir__, "support/**/*.rb")].each { |x| require(x) }

RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = :expect }

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.disable_monkey_patching!
  config.raise_errors_for_deprecations!
  config.expose_dsl_globally = true

  config.order = :random
  Kernel.srand config.seed
end
