# frozen_string_literal: true

namespace :puma do
  desc 'Start Puma'
  task :start do
    on roles(:web) do
      within release_path do
        execute :sudo, :systemctl, :start, :puma
      end
    end
  end

  desc 'Rolling-Start for Puma'
  task 'phased-restart' do
    on roles(:web) do
      within release_path do
        execute :sudo, :systemctl, :reload, :puma
      end
    end
  end

  desc 'Normal Restart Puma'
  task :restart do
    on roles(:web) do
      within release_path do
        execute :sudo, :systemctl, :restart, :puma
      end
    end
  end

  desc 'Check current status of Puma'
  task :status do
    on roles(:web) do
      within current_path do
        execute :sudo, :systemctl, :status, :puma
      end
    end
  end

  desc 'Stop Puma'
  task :stop do
    on roles(:web) do
      within release_path do
        execute :sudo, :systemctl, :stop, :puma
      end
    end
  end
end
