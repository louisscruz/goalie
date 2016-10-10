Rails.application.routes.draw do
  resources :users, only: [:show, :new, :create, :edit, :update, :destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :goals
  root to: "sessions#new"
end
