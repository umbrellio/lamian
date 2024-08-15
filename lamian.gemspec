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
  spec.license = "MIT"

  spec.required_ruby_version = Gem::Requirement.new(">= 3.1.0")
  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.include?("spec") }
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", ">= 4.2"
end
