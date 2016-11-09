Rails::application.routes.draw do


  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  get 'admin' => 'admin#index'
  get "admin/index" => 'admin/index'
  get "admin/events" => 'admin/events'
  post "lock_event" => "admin#lock_event"

  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'signup' => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'

  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]

  get 'static_pages/home'

  resources :events do
    collection do
      post :squash_many_duplicates
      get :search
      get :duplicates
      get 'tag/:tag', action: :search, as: :tag
    end

    member do
      get :clone
    end

  end

  resources :venues do
    collection do
      post :squash_many_duplicates
      get :map
      get :duplicates
      get :autocomplete
      get 'tag/:tag', action: :index, as: :tag
    end
  end

  # resources :changes, controller: 'paper_trail_manager/changes'

  # In Rails 4.1+, we could use a leading slash to the controller path:
  # resources :changes, controller: '/paper_trail_manager/changes'

  # get 'recent_changes' => redirect("/changes")
  # get 'recent_changes.:format' => redirect("/changes.%{format}")

  # get 'css/:name' => 'site#style'
  # get 'css/:name.:format' => 'site#style'

  get '/' => 'site#index', :as => :root
  get '/index' => 'site#index'
  get '/index.:format' => 'site#index'
  get 'about' => 'site#about'


  # devise_for :users
  # root to: 'pages#index'
  # get '/secret', to: 'pages#secret', as: :secret

  # root 'movies#index'

  # get 'auth/:provider/callback'=>'sessions#create'
  # get 'logout'=>'sessions#destroy', :as => :logout
  # get 'auth/failure'=>'sessions#failure'

end
