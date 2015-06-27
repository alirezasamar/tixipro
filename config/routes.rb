Rails.application.routes.draw do

  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'register' }
  scope "/admin" do
    resources :users
  end

  resources :discounts
  mount Ckeditor::Engine => '/ckeditor'

  resources :events do
    resources :tickets
  end

  authenticated :user do
    root :to => 'events#index', as: :authenticated_root
  end
  root :to => 'events#index'

end
