require "capistrano/plugin"
require "capistrano/precompile_chooser/version"

module Capistrano
  class PrecompileChooser < Capistrano::Plugin

    # ### Currently using `namespace :load` in rake file instead
    # def set_defaults
    #   case precompile_mode
    #   when "local"
    #     # set_if_empty :foo, :bar
    #   when "remote"
    #     # Do nothing
    #   else
    #     # Do nothing
    #   end
    # end

    def define_tasks
      case precompile_mode
      when "local"
        eval_rakefile File.expand_path("../precompile_chooser/local_precompile.rake", __FILE__)
      when "remote"
        require 'capistrano/rails/assets' ### Disable for local precompile
      else
        # Do nothing
      end
    end

    def register_hooks
      case precompile_mode
      when "local"
        after "bundler:install", "deploy:assets:local_precompile:prepare"
        after "deploy:assets:local_precompile:prepare", "deploy:assets:local_precompile:rsync"
        after "deploy:assets:local_precompile:rsync", "deploy:assets:local_precompile:cleanup"
      else
        # Do nothing
      end
    end

    def precompile_mode
      @precompile_mode ||= begin
        val = ENV['PRECOMPILE_MODE']
        if ENV['PRECOMPILE_MODE']
          if !valid_mode?(ENV['PRECOMPILE_MODE'])
            raise "Invalid Precompile Mode"
          end
        else
          val = nil

          until valid_mode?(val)
            puts
            puts "How do you want to compile assets? (#{PRECOMPILE_MODES.join('/')})"
            val = STDIN.gets.strip.downcase
          end

          puts
        end

        val
      end
    end

    private

    def valid_mode?(mode)
      mode && PRECOMPILE_MODES.include?(mode)
    end

    PRECOMPILE_MODES = ['local','remote','skip'].freeze

  end
end

install_plugin Capistrano::PrecompileChooser
