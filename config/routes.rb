Neutral::Engine.routes.draw do
  resources :votes, only: [:create, :update, :destroy]
end
