Rails.application.routes.draw do
  root 'astro#home'
  get '/astro', to: 'astro#show'
  
end
