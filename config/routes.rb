Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'homes#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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

  resources :repertory_dbs, only: :index do
    collection do
      get :export
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

  resources :users, except: [:show] do
    member do
      patch :admin_update
    end
  end

  post 'sessions/login' => 'sessions#create'
  post 'sessions/visit' => 'sessions#visit'
  delete 'sessions/logout' => 'sessions#destroy'
  delete 'sessions/visit_out' => 'sessions#destroy_visit'


  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
