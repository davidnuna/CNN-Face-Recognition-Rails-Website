Rails.application.routes.draw do
  devise_for :users, :controllers => {:sessions => "sessions"}, :path_names => { :sign_in => 'login', :sign_out => 'logout' }
  root 'pages#home'

  get '/home' => 'pages#home'

  resources :users, only: [:show, :index]
  
  resources :logins, only: [:index, :new, :create] do
    member do
      get :select_user
      post :choose_user
      get :login_page
    end
  end

  get 'quizzes/add_question' => 'quizzes#add_question'
  resources :quizzes, only: [:index, :show, :new, :create] do
    member do
      post :answer
    end
  end
  
end
