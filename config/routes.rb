SampleApp::Application.routes.draw do
  #get "users/new"

  #get "pages/home"
  #get "pages/contact"  
  #get "pages/about"
  
  # get "static_pages/home"
  # get "static_pages/contact"  
  # get "static_pages/about"  
  # get "static_pages/help"

  # match '/', to: 'static_pages#home'
  
  
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"
  
  #resources :users # generates REST URI resources: GET POST PUT Destroy/DELETE  REFACTORED BELOW IN Ch 11
  
  #Ch 11 Refactored for followers http://ruby.railstutorial.org/chapters/following-users#code-following_followers_actions_routes
  # http://ruby.railstutorial.org/chapters/following-users#table-following_routes
  resources :users do
    member do
      get :following, :followers
    end
    # Ch 11 :)  The other possibility, collection, works without the id, so that would respond to the URL /users/tigers (presumably to display all the tigers in our application). 
    # collection do
      # get :tigers # :))
    # end
  end
  
  
  resources :sessions, only: [:new, :create, :destroy] # same as above only for 3 actions in Session controller
  resources :microposts, only: [:create, :destroy] # ch 10 microposts
  resources :relationships, only: [:create, :destroy] # Ch 11 
  
  root to: 'static_pages#home'
  
  match '/signup',  to: 'users#new' # UsersController
  match '/signin',  to: 'sessions#new' #SessionsController
  match '/signout', to: 'sessions#destroy', via: :delete
  #route to host/session for create is already implicitly routed by >>> resources :session, only: [:new, :create, :destroy] 
  
  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  



  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
