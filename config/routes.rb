Rails.application.routes.draw do
  resources :stocks
  resources :transactions
  resources :inventories
  resources :cashes
  devise_for :users, :controllers => {:registrations => "users/registrations",
    :sessions => "users/sessions"}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  get '/admin/transactions' => 'home#show', as: 'client_transactions'
  get '/admin/clients' => 'users#index', as: 'client_list'
  get '/admin/client/:id' => 'users#show', as: 'client'
  get '/admin/clients/new' => 'users#new', as: 'new_client'
  post '/admin/client/create' => 'users#create', as: 'create_client'
  get '/admin/client/:id/edit' => 'users#edit', as: 'edit_client'
  post '/admin/client/:id/update' => 'users#update', as: 'update_client'
  post '/admin/clients/action' => 'users#client_action', as: 'client_action'
end
