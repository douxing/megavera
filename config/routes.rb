Rails.application.routes.draw do
  root 'home#show'

  scope "/:locale", locale: /en|zh/ do
    resource :home, controller: 'home', only: [:show] do
      member do
        get :contact
        get :career
        get :news
        get :specialities
        get :typical_solution
        get :about
      end
    end
  end

  resources :news, controller: 'news', expect: [:index]
  get '/login' => 'home#login'
  delete '/logout' => 'home#logout'
  get '/:locale' => 'home#show'
end
