namespace :load do
  task :defaults do
    set_if_empty :assets_dir,  "public/assets"
    set_if_empty :packs_dir,   "public/packs"
    set_if_empty :rsync_cmd,   "rsync -av --delete"
    set_if_empty :assets_role, "web"
  end
end

namespace :deploy do
  namespace :assets do
    namespace :local_precompile do

      desc "Remove all local precompiled assets"
      task :cleanup do
        run_locally do
          execute "rm", "-rf", fetch(:assets_dir)
          execute "rm", "-rf", fetch(:packs_dir)
        end
      end

      desc "Actually precompile the assets locally"
      task :prepare do
        run_locally do
          execute "RAILS_ENV=#{fetch(:rails_env)} bundle exec rake assets:clean"
          execute "RAILS_ENV=#{fetch(:rails_env)} bundle exec rake assets:precompile"
        end
      end

      desc "Performs rsync to app servers"
      task :rsync do
        on roles(fetch(:assets_role)), in: :parallel do |server|
          run_locally do
            remote_shell = %(-e "ssh -p #{server.port}") if server.port

            commands = []
            commands << "#{fetch(:rsync_cmd)} #{remote_shell} ./#{fetch(:assets_dir)}/ #{server.user}@#{server.hostname}:#{release_path}/#{fetch(:assets_dir)}/" if Dir.exist?(fetch(:assets_dir))
            commands << "#{fetch(:rsync_cmd)} #{remote_shell} ./#{fetch(:packs_dir)}/ #{server.user}@#{server.hostname}:#{release_path}/#{fetch(:packs_dir)}/" if Dir.exist?(fetch(:packs_dir))

            commands.each do |command|
              if dry_run?
                SSHKit.config.output.info command
              else
                execute command
              end
            end
          end
        end
      end

    end
  end
end
