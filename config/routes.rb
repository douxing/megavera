Rails.application.routes.draw do
  root 'home#show'

  resource :home, controller: 'home', only: [:show] do
    member do
      get :contact
      get :careers
    end
  end
end
