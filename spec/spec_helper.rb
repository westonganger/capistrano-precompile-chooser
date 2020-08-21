require 'rake'
require 'rspec'
require "capistrano/all"
require "capistrano/precompile_chooser"
require 'capistrano-spec'

RSpec.configure do |config|
  config.include Capistrano::Spec::Matchers
  config.include Capistrano::Spec::Helpers

  config.expect_with(:rspec) do |c|
    c.syntax = [:should, :expect]
  end
end
