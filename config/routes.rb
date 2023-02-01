Rails.application.routes.draw do
  resources :drones

  root to: 'drones#index'
end
