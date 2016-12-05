Rails.application.routes.draw do

  namespace :dashboard do
    resources :txns, only: %i[new create show]
    resources :claims, only: %i[new create show]
  end

  namespace :api do
    namespace :v1 do
      resources :txns, only: %i[update]
      resources :bridge do
        collection do
          post :receive
          post :error
        end
      end
    end
  end

end
