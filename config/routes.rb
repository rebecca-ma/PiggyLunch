Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get '/not_found', to: 'welcome#not_found', as: 'not_found'

  get '/people', to: 'users#index', as: 'users'
  get '/profile/:id', to: 'users#show', as: 'show_user'
  get '/people/new', to: 'users#new', as: 'new_user'
  get '/profile/:id/edit', to: 'users#edit', as: 'edit_user'
  post '/people/new', to: 'users#create', as: 'create_user'
  post '/profile/:id/edit', to: 'users#update', as: 'update_user'
  delete '/profile/:id/delete', to: 'users#delete', as: 'delete_user'

  get '/restaurants', to: 'restaurants#index', as: 'restaurants'
  get '/restaurant/:id', to: 'restaurants#show', as: 'show_restaurant'
  get '/restaurants/new', to: 'restaurants#new', as: 'new_restaurant'
  get '/restaurant/:id/edit', to: 'restaurants#edit', as: 'edit_restaurant'
  post '/restaurants/new', to: 'restaurants#create', as: 'create_restaurant'
  patch '/restaurant/:id/edit', to: 'restaurants#update', as: 'update_restaurant'
  delete '/restaurant/:id/delete', to: 'restaurants#delete', as: 'delete_restaurant'

  get '/restaurant/:id/rate', to: 'piggies#new', as: 'new_piggy'
  get '/restaurant/:restaurant_id/:id/edit', to: 'piggies#edit', as: 'edit_piggy'
  post '/restaurant/:id/rate', to: 'piggies#create', as: 'create_piggy'
  patch '/restaurant/:restaurant_id/:id/edit', to: 'piggies#update', as: 'update_piggy'

  get '*path' => redirect('/not_found')
end
