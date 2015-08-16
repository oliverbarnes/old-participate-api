Rails.application.routes.draw do

  get '/me', to: 'me#show'

  match 'proposals/:id', to: 'proposals#index', via: [:options]

  resources :tokens, only: :create
  jsonapi_resources :proposals
  resources :supports
end
