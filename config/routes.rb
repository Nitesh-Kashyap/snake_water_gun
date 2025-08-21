Rails.application.routes.draw do
  devise_for :users
  root "rounds#new"
  resources :rounds, only: [:new, :create, :index, :show]
end
