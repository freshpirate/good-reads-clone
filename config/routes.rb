GoodReads::Application.routes.draw do

  # get "/spam_domains", to: "spam_domain#index", as: :spam_index
  # post "/spam_domains", to: "spam_domain#create", as: :new_spam

  resources :books


  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'

  root :to => "static_pages#home"

  resources :spam_domain,           only: [:create, :index]
  delete "/spam_domain", to: "spam_domain#destroy", as: :delete_spam

  resources :users,           only: [:new, :create, :index, :show, :edit, :update, :destroy]
  resources :user_sessions,   only: [:create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :book_relationships, only: [:create, :update, :destroy]  
  resources :statuses, only: [:create, :update, :destroy]
  resources :my_books, only: [:index]


  delete '/sign_out', to: "user_sessions#destroy", as: :sign_out
  get '/sign_in', to: "user_sessions#new", as: :sign_in

  # New User Registration confirmation
  get '/confirm_user/:id/:token', to: "users#confirm", as: :email_confirmation

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
