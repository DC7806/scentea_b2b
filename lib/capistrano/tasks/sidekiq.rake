# frozen_string_literal: true

namespace :sidekiq do
  desc 'Srart Sidekiq'
  task :start do
    on roles(:app) do
      within release_path do
        execute :sudo, :systemctl, :start, :sidekiq
      end
    end
  end

  desc 'Quiet Sidekiq (Stop fetching new tasks from Redis)'
  task :quiet do
    on roles(:app) do
      within release_path do
        execute :sudo, :systemctl, :kill, '-s', 'TSTP', 'sidekiq'
      end
    end
  end

  desc 'Stop Sidekiq (Graceful shutdown within timeout, put unfinished tasks back to Redis)'
  task :stop do
    on roles(:app) do
      within release_path do
        execute :sudo, :systemctl, :stop, :sidekiq
      end
    end
  end

  desc 'Normal Restart to Sidekiq'
  task :restart do
    invoke! 'sidekiq:stop'
    invoke! 'sidekiq:start'
  end

  desc 'Check current status of Sidekiq'
  task :status do
    on roles(:app) do
      execute :sudo, :systemctl, :status, :sidekiq
    end
  end
end
