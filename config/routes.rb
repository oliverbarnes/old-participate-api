Rails.application.routes.draw do

  jsonapi_resource :me

  match 'proposals/:id', to: 'proposals#index', via: [:options]

  resource :token, only: :create
  jsonapi_resources :proposals
  jsonapi_resources :participants
  jsonapi_resources :supports
  jsonapi_resources :suggestions
  jsonapi_resources :delegations
end
