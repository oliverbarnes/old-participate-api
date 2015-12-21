Rails.application.routes.draw do

  jsonapi_resource :me

  match 'proposals/:id', to: 'proposals#index', via: [:options]

  resources :tokens, only: :create
  jsonapi_resources :proposals
  jsonapi_resources :participants
  resources :supports
  jsonapi_resources :delegations
  # Hide until we develop the front-end and decide on the api call
  # resources :suggestions, only: [:show, :create]
end
