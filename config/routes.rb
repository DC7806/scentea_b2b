Rails.application.routes.draw do
  devise_for :admin_users

  root to: 'pages#index'

  namespace :admin, path: ENV['ADMIN_PATH'] do
    root to: 'pages#index'
  end
end
