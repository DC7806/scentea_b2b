Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users,
             controllers: {
               sessions: 'admin_users/sessions',
               passwords: 'admin_users/passwords'
             }

  root to: 'pages#index'

  namespace :admin, path: ENV['ADMIN_PATH'] do
    root to: 'pages#index'

    resource :admin_users, only: %i[edit update], as: :user
  end
end
