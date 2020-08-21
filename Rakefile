require File.expand_path(File.dirname(__FILE__) + '/lib/capistrano/precompile_chooser/version')
require 'bundler/gem_tasks'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

task test: :spec

task default: :spec

task :console do
  require 'capistrano/precompile_chooser'

  require 'irb'
  binding.irb
end
