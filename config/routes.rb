Rails.application.routes.draw do

  devise_for :users, path_names: { sign_in: :login, sign_out: :logout }

  resources :drones do
    resources :comments, shallow: true
  end

  resources :categories
  resources :likes, only: %i[create destroy]

  root to: 'drones#index'
end
