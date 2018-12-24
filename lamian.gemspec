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

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^spec/}) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 4.2"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency "json"
  spec.add_development_dependency "launchy"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "yard"
end
