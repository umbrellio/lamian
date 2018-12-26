# coding: utf-8
# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "lamian/version"

Gem::Specification.new do |spec|
  spec.name = "lamian"
  spec.version = Lamian::VERSION
  spec.authors = ["JelF"]
  spec.email = ["begdory4+lamian@gmail.com"]

  spec.summary = "Add logs to your error messages"
  spec.description = "Add logs to your error messages, using exception_notifier or smth like it"
  spec.homepage = "https://github.com/umbrellio/lamian"

  spec.files = Dir["lib/**/*"]
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 4.2"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rubocop-config-umbrellio", "= 0.49.1.4"
  spec.add_development_dependency "pry", "~> 0.10"
  spec.add_development_dependency "coveralls", "~> 0.8"
  spec.add_development_dependency "yard", "~> 0.9"
  spec.add_development_dependency "launchy", "~> 2.4.3"
  spec.add_development_dependency "json", ">= 2.1.0"
  spec.add_development_dependency "sentry-raven", "~> 2.7.4"
end
