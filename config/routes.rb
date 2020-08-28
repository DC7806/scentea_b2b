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

    resources :articles, only: %i[index show], param: :slug

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
    mount Shrine.presign_endpoint(:cache) => '/s3/params'
    post 'ckeditor_upload/:scope', to: 'ckeditor_images#upload'

    root to: 'pages#index'

    resource :admin_users, only: %i[edit update], as: :user
    resource :site_settings, only: %i[edit update]

    resources :regions, path: '', only: [] do
      resources :accounts, only: %i[index edit update]
      resources :articles, except: :show

      %i[carousels faqs faq_categories article_categories].each do |res|
        resources res, except: :show do
          collection { patch :sort }
        end
      end
    end
  end
end
