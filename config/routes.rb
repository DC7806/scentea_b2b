# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    devise_for :users,
               controllers: {
                 registrations: 'users/registrations',
                 sessions: 'users/sessions',
                 passwords: 'users/passwords'
               }

    root to: 'pages#homepage'
    get :faq, to: 'pages#faq'

    resource :account, only: %i[edit update] do
      scope module: :accounts do
        resource :registrations, as: :registration, only: %i[new create] do
          collection { get :complete }
        end
      end
    end
  end

  devise_for :admin_users,
              controllers: {
                sessions: 'admin_users/sessions',
                passwords: 'admin_users/passwords'
              }

  namespace :admin, path: ENV['ADMIN_PATH'] do
    root to: 'pages#index'

    resource :admin_users, only: %i[edit update], as: :user

    resources :regions, path: '', only: [] do
      resources :accounts, only: %i[index edit update]

      %i[faqs faq_categories].each do |res|
        resources res, except: :show do
          collection { patch :sort }
        end
      end
    end
  end
end
