Rails.application.routes.draw do
  resources :transactions
  resources :inventories
  resources :cashes
  devise_for :users, :controllers => {:registrations => "users/registrations"}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  get '/dashboard' => 'home#show'
end
