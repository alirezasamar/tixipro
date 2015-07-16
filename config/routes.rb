Rails.application.routes.draw do

  resources :line_items
  resources :carts
  get "carts/delete_cart/:id" => "carts#delete_cart"
  # get 'store/index'

  mount Bootsy::Engine => '/bootsy', as: 'bootsy'

  resources :halls
  # devise_for :users, :path => '/', controllers: {omniauth_callbacks: "authentications", registrations: "registrations"}

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  scope "/admin" do
    resources :events
    resources :user, :controller => "user"
  end

  resources :events do
    resources :uploads
    resources :tickets
    resources :discounts
  end


  resources :payments

  post "/payments/:id" => "payments#show"
  post "/hook" => "payments#hook"

  get "/my_tickets" => "tickets#my_tickets"

  get "/assign_tickets" => "tickets#assign_tickets"

  post "/special_checkout" => "line_items#special_checkout"

  put "/subcurator_tickets" => "tickets#subcurator_tickets"

  put "/ticket_update_name" => "tickets#ticket_update_name"

  get "/tickets_customization" => "tickets#tickets_customization"

  get "/my_invoices" => "payments#my_invoices"

  get "/faq" => "store#faq"

  get "store/venue" => "store#venue"

  get "/print_tickets" => "tickets#print_tickets"

  root :to => 'store#index' , :as => 'store'

end
