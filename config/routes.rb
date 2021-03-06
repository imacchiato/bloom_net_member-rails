Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount StellarLookout::Engine => "/stellar_lookout"
  devise_for :users
  namespace :dashboard do
    get '/' => 'home#index'
    resource :search
    resources :txns, only: %i[new create show index]
    resources :claims, only: %i[new create show index]
    resource :user
  end

  namespace :api do
    namespace :v1 do
      resources :txns, only: %i[update]
      jsonapi_resources :claims, only: %i[create]
      resources :bridge do
        collection do
          post :receive
          post :error
        end
      end
    end
  end

  root "home#index"

end
