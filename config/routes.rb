Rails.application.routes.draw do

  resources :line_items
  resources :carts
  # get 'store/index'

  mount Bootsy::Engine => '/bootsy', as: 'bootsy'

  resources :halls
  devise_for :users, :path => '/', controllers: {omniauth_callbacks: "authentications", registrations: "registrations"}

  scope "/admin" do
    resources :users
  end

  resources :events do
    resources :tickets
    resources :discounts
  end


  resources :payments

  post "/payments/:id" => "payments#show"
  post "/hook" => "payments#hook"

  get "/my_tickets" => "line_items#my_tickets"

  authenticated :user do
    root :to => 'events#index', as: :authenticated_root
  end
  root :to => 'store#index' , :as => 'store'

end
