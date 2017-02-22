Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/people', to: 'users#index', as: 'users'
  get '/profile/:id', to: 'users#show', as: 'show_user'
  get '/people/new', to: 'users#new', as: 'new_user'
  get '/profile/:id/edit', to: 'users#edit', as: 'edit_user'
  post '/people/new', to: 'users#create', as: 'create_user'
  post '/profile/:id/edit', to: 'users#update', as: 'update_user'
  
  get '/restaurants', to: 'restaurants#index', as: 'restaurants'
  get '/restaurant/:id', to: 'restaurants#show', as: 'show_restaurant'
  get '/restaurant/new', to: 'restaurants#new', as: 'new_restaurant'
  get '/restaurant/:id/edit', to: 'restaurants#edit', as: 'edit_restaurant'
  post '/restaurant/new', to: 'restaurants#create', as: 'create_restaurant'
  post '/restaurant/:id/edit', to: 'restaurants#update', as: 'update_restaurant'

end
