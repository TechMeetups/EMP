TechMeetsUp::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :events
  
  get "home/index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  post 'events/event_search'
  get 'events/event_search'
  post 'events/event_search_type'
  get 'events/event_search_type'
  get 'notifications'=> 'home#notifications', as: :notifications
  get 'accept_proposal'=> 'home#accept_proposal', as: :accept_proposal
  post 'add_banners'=> 'home#add_banners', as: :add_banners
  post 'add_more'=> 'home#add_more', as: :add_more
  post 'banner_destroy'=> 'home#banner_destroy', as: :banner_destroy
  post 'update_avatar'=> 'home#update_avatar', as: :update_avatar

  get 'profile/:id' => "home#profile", as: :user_profile
  get 'home/looking_for'
  get 'home/offer'
  get 'home/destroy_event_user'
  get 'events/destroy_event/:event_id' => "events#destroy_event", as: :destroy_event
  post 'host_change'=> 'home#host_change', as: :host_change
  post 'venue_change'=> 'home#venue_change', as: :venue_change
  post 'events/new'
  post 'event/interaction' => "events#event_interaction"
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view
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
