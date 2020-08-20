require 'rspec'
require 'capistrano-spec'
require "capistrano/precompile_chooser"

RSpec.configure do |config|
  config.expect_with(:rspec) do |c|
    c.syntax = [:should, :expect]
  end
end
