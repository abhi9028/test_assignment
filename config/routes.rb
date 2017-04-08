Rails.application.routes.draw do

  devise_for :users
  
  resources :products, only: [:index, :show]

  resources :order_items, only: [:create, :update, :destroy]

  root to: 'products#index'

  resources :orders, only: [:index] do
    get :thank_you, on: :member
  end

  get 'shopping-bag' => 'orders#shopping_bag'

  resources :checkout do
    post :charge, on: :collection
  end

end