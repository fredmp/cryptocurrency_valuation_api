Rails.application.routes.draw do

  resources :valuation_settings, only: [:index, :create, :update, :destroy], path: 'valuation-settings'
  resources :tracked_currencies, only: [:index, :create, :update, :destroy], path: 'tracked', param: :symbol do
    get 'ids', on: :collection
  end
  resources :assets, only: [:index, :create, :update, :destroy], param: :symbol
  resources :valuations, only: [:update]
  resources :currencies, only: [:index]
  resources :status, only: [:index]
  resources :login, only: [:create]
  resources :users, only: [:create, :update]
end
