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
  resources :users, except: [:new]

  #user_sessions routes
  get 'login' => 'usersessions#new'
  post 'login' => 'usersessions#create'
  delete 'logout' => 'usersessions#destroy'
  get 'logout' => 'usersessions#destroy'

end
