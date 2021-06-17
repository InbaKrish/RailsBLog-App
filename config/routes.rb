Rails.application.routes.draw do
  devise_for :authors, except: [:destroy]
  root "pages#home"

  devise_scope :author do
    get '/authors/sign_out' => 'devise/sessions#destroy', as: 'destroy_authsession'
  end

  #article routes
  resources :articles, except: [:destroy] do
    resources :comments
  end
  delete 'articles/:id/delete' => 'articles#destroy', as: 'articles_delete'
  get '/articles/:id/delete' => 'articles#destroy'

  # user routes
  get 'signup' => 'users#new'
  resources :users, except: [:new, :destroy] 

  delete '/users/:id/delete' => 'users#destroy', as: 'delete_user'
  get '/users/:id/delete' => 'users#destroy'

  #savedarticles routes
  get '/articles/:article_id/savedarticles/new' => 'savedarticles#create', as: 'savearticle'
  delete '/articles/:article_id/removesaved' => 'savedarticles#destroy', as: 'removefromsaved'
  get '/author/:author_id/savedarticles' => 'savedarticles#index', as: 'savedarticles'
  get '/articles/:article_id/removesaved' => 'savedarticles#destroy'

end
