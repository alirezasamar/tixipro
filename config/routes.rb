Rails.application.routes.draw do

  get 'uploads/new'

  resources :line_items
  resources :carts
  get "carts/delete_cart/:id" => "carts#delete_cart"
  # get 'store/index'

  mount Bootsy::Engine => '/bootsy', as: 'bootsy'

  resources :halls
  resources :uploads
  # devise_for :users, :path => '/', controllers: {omniauth_callbacks: "authentications", registrations: "registrations"}

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  scope "/admin" do
    resources :events
    resources :user, :controller => "user"
  end

  resources :events do
    resources :tickets
    resources :discounts
  end


  resources :payments

  post "/payments/:id" => "payments#show"
  post "/hook" => "payments#hook"

  get "/my_tickets" => "tickets#my_tickets"

  post "/special_checkout" => "line_items#special_checkout"

  get "/my_invoices" => "payments#my_invoices"

  get "/faq" => "store#faq"

  get "store/venue" => "store#venue"

  root :to => 'store#index' , :as => 'store'

end
