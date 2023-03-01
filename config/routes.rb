Rails.application.routes.draw do

  devise_for :users, path_names: { sign_in: :login, sign_out: :logout }

  resources :drones do
    member do
      patch "upvote", to: "drones#upvote"
    end
    resources :comments
  end

  resources :categories

  root to: 'drones#index'
end
