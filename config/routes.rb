Rails.application.routes.draw do

  devise_for :users
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
  root :to => 'welcome#index'

end
