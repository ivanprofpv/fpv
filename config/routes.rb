Rails.application.routes.draw do

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

  root to: 'drones#index'
end
