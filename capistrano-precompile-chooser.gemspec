lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/precompile_chooser/version'

Gem::Specification.new do |s|
  s.name        = 'capistrano-precompile-chooser'
  s.version     =  Capistrano::PrecompileChooser::VERSION
  s.author	= "Weston Ganger"
  s.email       = 'weston@westonganger.com'
  s.homepage 	= 'https://github.com/westonganger/capistrano-precompile-chooser'
  
  s.summary     = "Capistrano plugin to precompile your Rails assets locally, remotely, or not at all provided with a very convenient default terminal prompt."

  s.description = s.summary 

  s.files = Dir.glob("{lib/**/*}") + %w{ LICENSE README.md Rakefile CHANGELOG.md }
  s.require_path = 'lib'

  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency "capistrano", ">= 3.1"
  
  s.add_development_dependency 'rake'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'capistrano-spec'
end
