Rails.application.routes.draw do
  root "pages#home"

  #article routes
  resources :articles, except: [:destroy] do
    resources :comments
  end
  delete 'articles/:id/delete' => 'articles#destroy', as: 'articles_delete'
  get '/articles/:id/delete' => 'articles#destroy'

  # user routes
  get 'signup' => 'users#new'
  resources :users, except: [:new, :destroy] do
    resources :savedarticles, except: [:new, :destroy]
  end
  delete '/users/:id/delete' => 'users#destroy', as: 'delete_user'
  get '/users/:id/delete' => 'users#destroy'

  #savedarticles routes
  get '/articles/:article_id/savedarticles/new' => 'savedarticles#create', as: 'savearticle'
  delete '/articles/:article_id/removesaved' => 'savedarticles#destroy', as: 'removefromsaved'
  get '/articles/:article_id/removesaved' => 'savedarticles#destroy'

  #user_sessions routes
  get 'login' => 'usersessions#new'
  post 'login' => 'usersessions#create'
  delete 'logout' => 'usersessions#destroy'
  get 'logout' => 'usersessions#destroy'

end
