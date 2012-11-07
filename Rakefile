require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubygems'
require 'cucumber'
require 'cucumber/rake/task'

RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.ruby_opts = "-I lib:spec"
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rspec_opts = "--color -f documentation"
end
task :spec

Cucumber::Rake::Task.new(:features) do |t|
  t.profile = 'default'
end

task :default => :features
