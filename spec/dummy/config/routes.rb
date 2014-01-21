Rails.application.routes.draw do
  resources :sessions, only: [:create, :new, :destroy]

  neutral

  get "sessions/destroy", as: "logout"
  get "sessions/new", as: "login"

  resources :posts, only: [:create, :new, :index]
  resources :users, only: [:create, :new]

  root to: "posts#index"
end
