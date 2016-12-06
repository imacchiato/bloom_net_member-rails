Rails.application.routes.draw do

  namespace :dashboard do
    resources :txns, only: %i[new create show]
    get '/' => 'home#index'
  end

end
