Rails.application.routes.draw do
  root "pages#home"

  #article routes
  resources :articles, except: [:destroy]
  delete 'articles/:id/delete' => 'articles#destroy', as: 'articles_delete'
  get '/articles/:id/delete' => 'articles#destroy'

  # user routes
  get 'signup' => 'users#new'
  resources :users, except: [:new]
end
