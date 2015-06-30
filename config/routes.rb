Rails.application.routes.draw do

  resources :halls
  devise_for :users, :path => '/', controllers: {omniauth_callbacks: "authentications", registrations: "registrations"}

  scope "/admin" do
    resources :users
  end

  mount Ckeditor::Engine => '/ckeditor'

  resources :events do
    resources :tickets
    resources :discounts
  end

  resource :cart, only: [:show]
  resources :order_items, only: [:create, :update, :destroy]
  resources :payments
  resource :confirm_order, only: [:show]
  resources :orders

  post "/payments/:id" => "payments#show"
  post "/hook" => "payments#hook"

  authenticated :user do
    root :to => 'events#index', as: :authenticated_root
  end
  root :to => 'events#index'

end
