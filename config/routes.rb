Rails.application.routes.draw do
  get 'posts/new'

  get 'posts/index'

  root 'static_pages#home'

  get '/about', to: 'static_pages#about'

  get '/login', to: 'sessions#new'

  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

  get '/signup', to: 'users#new'

  resources :users

  resources :posts, only: [:new, :create, :index]

end
