# frozen_string_literal: true
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'yard'
require 'pathname'
require 'launchy'
require 'uri'

ROOT = Pathname.new(__FILE__).join('..')

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new(:lint)

YARD::Rake::YardocTask.new(:doc) do |t|
  t.files = Dir[ROOT.join('lib/**/*.rb')]
  t.options = %w(--private)
end

def open_in_browser(path)
  Launchy.open(URI.join('file:///', path.to_s))
end

namespace :doc do
  desc 'open doc'
  task open: :doc do
    open_in_browser ROOT.join('doc/frames.html')
  end

  desc 'checks doc coverage'
  task coverage: :doc do
    # ideally you've already generated the database to .load it
    # if not, have this task depend on the docs task.
    YARD::Registry.load
    objs = YARD::Registry.select do |o|
      puts "pending #{o}" if o.docstring =~ /TODO|FIXME|@pending/
      o.docstring.blank?
    end

    next if objs.empty?
    puts 'No documentation found for:'
    objs.each { |x| puts "\t#{x}" }

    raise '100% document coverage required'
  end
end

task default: %i(lint doc:coverage spec)
