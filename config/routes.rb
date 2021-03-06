Rails.application.routes.draw do

  root 'static_pages#home'

  get '/about', to: 'static_pages#about'

  get '/login', to: 'sessions#new'

  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

  get '/signup', to: 'users#new'

  resources :users, only: [:show, :new, :create]

  resources :posts, only: [:new, :create, :index]

end
