Rails.application.routes.draw do
  resources :valuation_settings, only: [:index, :create, :update, :destroy], path: 'valuation-settings'
  resources :currencies, only: [:index]
  resources :status, only: [:index]
end
