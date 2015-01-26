# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, "megavera"
set :repo_url, "git://github.com/bsw85/megavera.git"

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call
set :branch, "master"

# Default deploy_to directory is /var/www/my_app
#set :deploy_to, "/var/www/my_app"

# Default value for :scm is :git
set :scm, :git

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml config/secrets.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# rvm
set :rvm_type, :user
set :rvm_ruby_version, '2.0'

# unicorn
set :unicorn_pid, -> { File.join(current_path, "tmp", "pids", "unicorn.pid") }
set :unicorn_config_path, -> { File.join(current_path, "config", "unicorn.rb") }
set :unicorn_rack_env, -> { fetch(:rails_env) == "development" ? "development" : "production" }

namespace :config do
  task :init do
    on roles(:app) do
      puts "Upload local files..."
      %w(database.yml secrets.yml).each do |file|
        # TODO: upload files
      end
    end
  end
end

namespace :deploy do
  task :start do
    on roles(:app) do
      within current_path do
        if test("[ -e #{fetch(:unicorn_pid)} ] && kill -0 `cat #{fetch(:unicorn_pid)}`")
          info "unicorn is running..."
        else
          with rails_env: fetch(:rails_env) do
            execute :bundle, "exec unicorn", "-c", fetch(:unicorn_config_path), "-E", fetch(:unicorn_rack_env), "-D"
          end
        end
      end
    end
  end

  task :stop do
    on roles(:app) do
      within current_path do
        if test("[ -e #{fetch(:unicorn_pid)} ]")
          if test("kill -0 `cat #{fetch(:unicorn_pid)}`")
            info "stopping unicorn..."
            execute :kill, "-s QUIT", "`cat #{fetch(:unicorn_pid)}`"
          else
            info "cleaning up dead unicorn pid..."
            execute :rm, fetch(:unicorn_pid)
          end
        else
          info "unicorn is not running..."
        end
      end
    end
  end

  desc 'Restart application'
  task :restart do
    invoke "deploy:start"
    on roles(:app), in: :sequence, wait: 5 do
      within current_path do
        info "unicorn restarting..."
        execute :kill, "-s USR2", "`cat #{fetch(:unicorn_pid)}`"
      end
    end
  end

  after :publishing, :restart
end
