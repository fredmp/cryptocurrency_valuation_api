Rails.application.routes.draw do
  get 'currencies', to: 'currencies#index'
  get 'status', to: 'status#index'
end
