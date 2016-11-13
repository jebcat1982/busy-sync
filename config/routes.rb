Rails.application.routes.draw do
  root 'site#index'

  resource :site, only: [:show]

  get 'auth/:provider/callback'        => 'sessions#create'
  get 'auth/failure'                   => 'sessions#failure'
  get '/logout',                       to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]
end
