Rails.application.routes.draw do

  root 'homes#index'


  resources :supplier_excels, only: [:index, :destroy, :create] do
    collection do
      get :clean
    end
    member do
      get :parse
    end
  end

  resources :supplier_dbs, only: :index do
    collection do
      get :export
    end
  end

  resources :repertory_excels, only: [:index, :destroy, :create] do
    collection do
      get :clean
    end
    member do
      get :parse
    end
  end

  resources :repertory_dbs, only: [:index, :update] do
    collection do
      get :export
      get :warning
    end
  end

  resources :project_excels, only: [:index, :destroy, :create] do
    collection do
      get :clean
    end
    member do
      get :parse
    end
  end


  resources :warning_dbs, only: [:index, :update] do
    collection do
      get :match
      get :match_page
    end
  end

  resources :warning_excels, only: [:index, :destroy, :create] do
    collection do
      get :clean
    end
    member do
      get :parse
    end
  end

  resources :project_dbs, only: :index do
    collection do
      get :export
    end
  end

  resources :stock_excels, only: [:index, :destroy, :create] do
    collection do
      get :clean
    end
    member do
      get :parse
    end
  end

  resources :stock_dbs, only: :index do
    collection do
      get :export
    end
  end

  resources :mapping_excels, only: [:index, :destroy, :create] do
    collection do
      get :clean
    end
    member do
      get :parse
    end
  end

  resources :mapping_dbs, only: :index do
    collection do
      get :export
    end
  end

  resources :users, except: [:new, :show] do
    collection do
      get :admin_new
      post :admin_create
    end
    member do
      patch :admin_update
    end
  end

  post 'sessions/login' => 'sessions#create'
  post 'sessions/visit' => 'sessions#visit'
  delete 'sessions/logout' => 'sessions#destroy'
  delete 'sessions/visit_out' => 'sessions#destroy_visit'
  get 'homes/get_warnings' => 'homes#get_warnings'


end
