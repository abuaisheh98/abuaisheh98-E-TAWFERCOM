require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  mount ActionCable.server => '/cable'

  get 'admins/importing_progress'
  get 'owners/index'
  get 'admins/index'
  get 'carts/index'
  get 'static_pages/add_to_cart'
  get 'static_pages/search'
  get 'static_pages/display_store'
  get 'static_pages/products_by_stores'
  get 'static_pages/products_by_category'
  #delete
  get 'carts/empty_cart'
  #post
  get 'carts/set_quantity_and_price'
  post 'carts/checkout'
  #delete
  post 'carts/remove_from_cart'
  post 'admins/create_user'
  get 'admins/new_user'
  get 'admins/display_categories'
  get 'admins/display_products'
  get 'admins/display_stores'
  get 'admins/products_by_categories'
  get 'admins/products_by_stores'
  get 'admins/import_products'
  post 'admins/import'
  get 'admins/edit_user/:id', as: 'edit_user',to: 'admins#edit'
  patch 'admins/update', as: 'edit_user_update', to: 'admins#update'
  delete 'admins/destroy/:id', as: 'admins_destroy', to: 'admins#destroy'
  resources :admins
  resources :categories
  resources :products
  resources :orders
  resources :stores
  root 'static_pages#home'
  devise_for :users
  
end
