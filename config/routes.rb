# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users,
             controllers: {
               sessions: 'admin_users/sessions',
               passwords: 'admin_users/passwords'
             }

  devise_for :users,
             controllers: {
               registrations: 'users/registrations'
             }

  root to: 'pages#index'

  namespace :admin, path: ENV['ADMIN_PATH'] do
    root to: 'pages#index'

    resource :admin_users, only: %i[edit update], as: :user

    resources :accounts, only: %i[index edit update]
  end
end
