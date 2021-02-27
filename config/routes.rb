Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :businesses do
    # resources :bookings, only: [ :index, :new, :create ]
    resources :reviews, only: [ :index, :new, :create ]
    resources :chatrooms, only: [:create, :show]
  end

  resources :bookings, except: [ :index, :new, :create ]
  resources :reviews, only: [ :show, :edit, :update, :destroy ]

  get '/components', to: 'pages#components', as: 'components'
  get '/account', to: 'pages#account', as: 'account'
  get '/my_businesses', to: 'pages#my_businesses', as: 'my_businesses'





  # for chatrooms
  resources :chatrooms, only: [:show, :index] do
    resources :messages, only: :create
    resources :bookings, only: [:new, :create, :show]
  end

  mount ActionCable.server => "/cable"
end
