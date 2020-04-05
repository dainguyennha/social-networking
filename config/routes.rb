Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'products#index'
  namespace :auth do
    resources :signups, only: [:new, :create]
    resources :sessions, only: [:new, :create, :destroy]
  end
end
