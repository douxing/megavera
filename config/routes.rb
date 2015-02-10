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

  resources :news, controller: 'news'
  resource :admin, controller: 'admin', only: [:show] do
    resource :password, controller: 'password', only: [:new, :create, :edit, :update]
  end

  get '/login' => 'admin#new_session'
  post '/login' => 'admin#create_session'
  delete '/logout' => 'admin#destroy_session'
  get '/:locale' => 'home#show'
end
