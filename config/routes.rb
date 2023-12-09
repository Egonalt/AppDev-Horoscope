Rails.application.routes.draw do
  root 'users#new'
  get '/home', to: 'astro#home', as: 'astro_home'
  get '/astro', to: 'astro#show', as: 'astro_show'
  get '/signup', to: 'users#new', as: 'signup'
  post '/users', to: 'users#create'
  get '/signin', to: 'sessions#new', as: 'signin'
  post '/sessions', to: 'sessions#create'
  get 'users/:id/stocks', to: 'users#stocks', as: :user_stocks
  delete '/logout', to: 'sessions#destroy', as: 'logout'
  
end
