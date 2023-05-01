Rails.application.routes.draw do
  resources :sessions, only: %i[create new]
  resources :registrations, only: %i[create new]
  get "/logout", to: "sessions#destroy", as: :logout
  resources :posts, only: %i[create new index edit update show]
  root "posts#index"
end
