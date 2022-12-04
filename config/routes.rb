Rails.application.routes.draw do
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
