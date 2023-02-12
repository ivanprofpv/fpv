Rails.application.routes.draw do
  devise_for :users, path_names: { sign_in: :login, sign_out: :logout }
  resources :drones
  resources :categories

  root to: 'drones#index'
end
