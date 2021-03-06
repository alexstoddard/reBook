Rebook::Application.routes.draw do
  resources :user_schedules

  resources :inventory_owns

  resources :users

  resources :books

  resources :feedbacks

  resources :trade_notes

  resources :user_feedbacks

  resources :trade_lines

  resources :trades 

  resources :conditions

  resources :inventory_needs

  resources :user_locations

  resources :locations
  
  root 'homepage#index'
  #user_routes
  get "edit_schedule/", to: 'users#edit_schedule'

  #matching routes
  get "matches", to: 'trades#matches'
  get "my_trades", to: 'trades#my_trades'
  get "match_details/:id", to: 'trades#match_details'
  
  #actions relating to trades
  get "/propose_trade/:json", to: 'trades#propose_trade'
  get "/trade_details/:trade_id", to: 'trades#trade_details'
  get "/update_trade/:id", to: 'trades#update_trade_show'
  post "/update_trade/:id", to: 'trades#update_trade'
  get "/accept_trade/:id", to: 'trades#accept_trade_show'
  post "/accept_trade/:id", to: 'trades#accept_trade'
  get "/decline_trade/:id", to: 'trades#decline_trade_show'
  post "/decline_trade/:id", to: 'trades#decline_trade'
  
  #user routes
  get "/forgot", to: 'users#forgot'
  post '/forgot', to: 'users#forgot_do'
  get "/reset", to: 'users#reset'
  put '/reset', to: 'users#reset_do'

  #homepage routes
  get "/about", to: 'homepage#about'
  get "/faq", to: 'homepage#faq'
  get "/terms", to: 'homepage#terms'

  #login/logout routes
  get '/login_failed', to: 'login#failed'
  get '/login_succeeded', to: 'login#succeeded'
  get '/login', to: 'login#show'
  get '/logout', to: 'login#logout'
  post '/login_try', to: 'login#attempt'

  #book search page routes
  get '/search', to: 'books#search'

  #book search page routes
  get '/location_books', to: 'locations#location_books'

  #inventory routes
  post '/inventory_owns', to: 'inventory_owns#create'
  post '/inventory_needs', to: 'inventory_needs#create'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

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
