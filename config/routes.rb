Rails.application.routes.draw do

  get 'articles/index'

  get 'articles/batch_update'

  resources :tracked_currencies, only: [:index, :create, :update, :destroy], path: 'tracked', param: :symbol do
    get 'ids', on: :collection
  end
  resources :currencies, only: [:index] do
    post 'batch_update', on: :collection
    post 'clean_up', on: :collection
    get 'popular', on: :collection
  end
  resources :valuation_settings, only: [:index, :create, :update, :destroy], path: 'valuation-settings' do
    post 'batch_create', on: :collection
  end
  resources :assets, only: [:index, :create, :update, :destroy], param: :symbol
  resources :valuations, only: [:update]
  resources :status, only: [:index]
  resources :users, only: [:create, :update] do
    post 'password_recovery', on: :collection
    post 'redefine_password', on: :collection
  end
  resources :articles, only: [:index] do
    post 'batch_update', on: :collection
  end

  post 'login', to: 'auth#create', as: :login
  get 'logout', to: 'auth#destroy', as: :logout
end
