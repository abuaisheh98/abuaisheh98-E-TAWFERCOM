Rails.application.routes.draw do
  get 'owners/index'
  get 'admins/index'
  get 'carts/index'
  get 'static_pages/add_to_cart'
  get 'carts/empty_cart'
  get 'carts/set_quantity_and_price'
  get 'carts/checkout'
  post 'static_pages/remove_from_cart'
  post 'admins/create_user'
  get 'admins/new_user'
  get 'admins/display_categories'
  get 'admins/display_stores'
  get 'admins/products_by_categories'
  get 'admins/products_by_stores'
  get 'admins/edit_user/:id', as: 'edit_user',to: 'admins#edit'
  patch 'admins/update', as: 'edit_user_update', to: 'admins#update'
  resources :admins
  resources :categories
  resources :products
  resources :orders
  resources :stores
  root 'static_pages#home'
  devise_for :users

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
