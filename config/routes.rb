Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  use_doorkeeper
  devise_for :authors, except: [:destroy]
  root "pages#home"

  devise_scope :author do
    get '/authors/sign_out' => 'devise/sessions#destroy', as: 'destroy_authsession'
  end

  #article routes
  resources :articles, except: [:destroy] do
    resources :comments, except: :destroy
  end
  delete 'articles/:id/delete' => 'articles#destroy', as: 'articles_delete'
  get '/articles/:id/delete' => 'articles#destroy'
  delete '/articles/:article_id/comment/delete' => 'comments#destroy', as: 'delete_comment'
  post '/articles/:article_id/like' => 'likes#create', as: 'like'
  get '/search' => 'articles#search', as: 'search'

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

  #api routes
  use_doorkeeper
    namespace :api do
      namespace :v1 do
        resources :authors 
      end
    end
  get '/api/v1/articles' => 'api/v1/articles#all_articles'
  get '/api/v1/articles/:id' => 'api/v1/articles#show',as: "api_v1_article"
  post '/api/v1/articles/new' => 'api/v1/articles#create',as: "api_create_article"
  get '/api/v1/authors/:id/articles' => 'api/v1/articles#index',as: "user_articles"

  #doorkeeper routes

    use_doorkeeper do
      skip_controllers :authorizations, :applications, :authorized_applications
    end

end
