Rails.application.routes.draw do

  resources :discounts
  devise_for :users
  mount Ckeditor::Engine => '/ckeditor'

  resources :events do
    resources :tickets
  end

  root 'events#index'
end
