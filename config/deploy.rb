# config valid for current version and patch releases of Capistrano
lock '~> 3.14.1'

set :application, 'scentea_b2b'
set :repo_url, 'git@github.com:DC7806/scentea_b2b.git'

# set :whenever_path, ->{ release_path }

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
ask(:branch, 'master')

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deploy/#{fetch :application}"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
set :pty, true
set :ssh_options, {:forward_agent => true}

# Default value for :linked_files is []
append :linked_files, 'config/database.yml', 'config/master.key'

# Default value for linked_dirs is []
append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', '.bundle', 'public/system', 'public/upload'

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
set :keep_releases, 10

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

after 'deploy:published', 'puma:phased-restart'
after 'deploy:starting',  'sidekiq:quiet'
after 'deploy:updated',   'sidekiq:stop'
after 'deploy:published', 'sidekiq:start'
# before 'deploy:finishing', 'sitemap:create'
# after 'deploy:finishing', 'whenever:update_cron'
after 'deploy:failed',    'sidekiq:restart'
