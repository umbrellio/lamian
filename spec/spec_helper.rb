# frozen_string_literal: true

require "bundler/setup"
require "logger"
require "pry"

require "coveralls"
Coveralls.wear!

require "lamian"

Dir[File.join(__dir__, "support/**/*.rb")].each { |x| require(x) }

RSpec.configure do |config|
  config.order = :random
end
