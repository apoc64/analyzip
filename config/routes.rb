Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  resources :states, only: [:index, :show]
  resources :counties, only: [:index, :show]
  resources :zips, only: [:index, :show]
  resources :users, only: [:show]
  resources :user_zips, only: [:create, :update, :destroy]

  get 'auth/:provider/callback', to: 'sessions#create'
  get '/Login', to: 'sessions#new'
  get '/Logout', to: 'sessions#destroy'
end
