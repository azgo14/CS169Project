CS169Project::Application.routes.draw do
  devise_for :users
  root :to => "videos#index"
  match "signin" => "application#custom_user_sign_in", :as => "sign_in"
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

  resources :users
  match '/users/block/:id' => 'users#block', :as => :block
  match '/users/unblock/:id' => 'users#unblock', :as => :unblock
    
  match '/videos/search' => 'videos#search', :as => :video_search

  resources :videos do
    member do
      post 'like'
      post 'create_comment'
    end
  end
  
  match '/messages/sent' => 'messages#sent', :as => :sent
  resources :messages


  namespace :admin do
    resources :videos
    match '' => 'videos#index'
    match '/videos/accept/:id' => 'videos#accept', :as => :accept
    match '/videos/pend/:id' => 'videos#pend', :as => :pend
    match '/videos/reject/:id' => 'videos#reject', :as => :reject
    match '/videos/email/:id' => 'videos#email', :as => :email
    post '/videos/send/:id' => 'videos#send_email', :as => :send
    resources :comments
    match '/comments/accept/:id' => 'comments#accept', :as => :accept
    match '/comments/reject/:id' => 'comments#reject', :as => :reject
  end

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
  # match ':controller(/:action(/:id(.:format)))'
end
