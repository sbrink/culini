Culini::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  ### Portal
  scope(:module => :shop, :constraints => { :host => /^(www\.)*culini/ }) do
    resource  :search, :only => [:show] do
      get :autocomplete
    end
    resources :pages do
      post :preview, :on => :collection
    end
    resources :users, :constraints => { :id => /\d+/ }, :only => [:index,:show]
    resources :user_addresses do
        put :set_as_default, :on => :member
    end
    resources :faxes
    resources :delayed_jobs
    resource :stores
    root :to => "Searches#show"
    #match "/categories" => redirect("/")
  end

  ### Store
  scope :module => :shop, :path => '(:store_id)', :store_id => /\d+/ do
    #match 'css/:id' => 'designs#css'
    resources :category_images, :reservations, :store_hours, :themes
    resource :cart
    resources :cart_articles, :only => [:create,:destroy,:edit] do
      put :inc, :on => :member
      put :dec, :on => :member
      put :cycle, :on => :member
      resources :cart_extras, :only => [:index,:create,:destroy]
    end
    resource :checkout do
      get :search
    end
    resources :categories do
      get :first, :on => :collection
      put :sort, :on => :collection
      resources :articles, :extras do
        put :sort, :on => :collection
      end
    end
    resource :design do
      get :screen
    end
    resource :info
    resources :orders do
      get :status, :on => :member
      get :preview, :on => :member
      post :interfax_callback, :on => :collection
    end
    #match 'categories', :to => "Categories#index", :as => :user_root
    root :to => "Categories#index"
  end

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)
end
