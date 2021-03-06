Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # root 'index#home'
  root 'sessions#new'

  get 'setlists/:id/reorder' => "setlists#reorder", as: :setlist_reorder

  resources :setlists do
    get 'invite' => 'setlists#invite'
    get 'send_invites' => 'setlists#send_invites'
    get 'player' => 'setlists#player'
  end

  get 'invite_code' => 'setlists#invite_code'
  get 'join' => 'setlists#join'

  resources :playlists, only: [:index, :show, :create]
  resources :users
  resources :votes
  resources :setlist_songs, only: [:update]

  resources :songs, only: [:create, :destroy]
  get "search" => "search#new"
  post "search" => "search#create"

  get "home" => "index#home"

  get "login" => "sessions#new", as: :login
  post "sessions" => "sessions#create"
  get 'logout' => 'sessions#destroy'

  get '/auth/:provider/callback' => 'sessions#create', as: :ouath_callback
  get '/auth/:provider' => 'sessions#new', as: :ouath_login


  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
