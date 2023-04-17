require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, lambda {|u| u.admin?} do
    mount Sidekiq::Web => '/admin/sidekiq'
  end

  devise_for :users, controllers: { registrations: 'users/registrations' }, path_names: { sign_in: :login, sign_out: :logout }
  resources :profiles, only: %i[ edit update show ]

  resources :drones do
    member do
      patch "upvote", to: "drones#upvote"
    end
    resources :comments, only: %i[ create upvote new update destroy]
    resources :components, shallow: true
  end

  resources :component_categories

  resources :comments do
      member do
        patch "upvote", to: "comments#upvote"
      end
    end

  resources :categories

  namespace :admin do
    resources :dashboard
    resources :profiles, only: %i[ edit update ]
  end

  get :search, to: 'search#index'

  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_server'
  get '/422', to: 'errors#unprocessable'

  root to: 'drones#index'
end
