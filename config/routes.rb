Rails.application.routes.draw do
  devise_for :users, :controllers => {:sessions => "sessions"}, :path_names => { :sign_in => 'login', :sign_out => 'logout' }
  root 'pages#home'

  get '/home' => 'pages#home'

  resources :users, only: [:show]
  
  resources :logins, only: [:show, :index, :new, :create] do
    get :select_user, :on => :member
    post :choose_user, :on => :member
    get :login_page, :on => :member
  end
  
end
