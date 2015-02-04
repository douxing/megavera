Rails.application.routes.draw do
  root 'home#show'

  resource :home, controller: 'home', only: [:show] do
    member do
      get :contact
      get :career
      get :news
      get :specialities
      get :typical_solution
      get :advantages
    end
  end
end
