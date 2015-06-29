Rails.application.routes.draw do

  get 'carts/:id', to: 'carts#show', as: 'current_cart', id: 'current'

  devise_for :users, :path => '/', controllers: {omniauth_callbacks: "authentications", registrations: "registrations"}

  scope "/admin" do
    resources :users
  end

  resources :discounts
  mount Ckeditor::Engine => '/ckeditor'

  resources :events do
    resources :tickets
  end

  resource :cart, only: [:show]
  resources :order_items, only: [:create, :update, :destroy]
  resources :payments

  authenticated :user do
    root :to => 'events#index', as: :authenticated_root
  end
  root :to => 'events#index'

end
