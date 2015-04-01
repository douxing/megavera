Rails.application.routes.draw do
  root 'home#show'
  mount Ckeditor::Engine => '/ckeditor'

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

  resources :news, controller: 'news'
  resources :slogans, controller: 'slogans'
  resource :admin, controller: 'admin', only: [:show] do
    member do
      get :social_recruitment, to: 'admin#edit_social_recruitment'
      put :social_recruitment, to: 'admin#update_social_recruitment'
      get :internship, to: 'admin#edit_internship'
      put :internship, to: 'admin#update_internship'
      get :theme, to: 'admin#edit_theme'
      put :theme, to: 'admin#update_theme'
      delete :theme, to: 'admin#destroy_theme'
    end

    resource :password, controller: 'password', only: [:new, :create, :edit, :update]
  end

  get '/login' => 'admin#new_session'
  post '/login' => 'admin#create_session'
  delete '/logout' => 'admin#destroy_session'
  get '/:locale' => 'home#show'
end
