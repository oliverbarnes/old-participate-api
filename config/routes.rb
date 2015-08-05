Rails.application.routes.draw do

  get '/me', to: 'me#show'

  match 'proposals/:id', to: 'proposals#index', via: [:options]

  resources :tokens, only: :create
  resources :proposals do
    resources :supports, only: [:index]
    resources :suggestions, shallow: true
  end
  resources :supports
end
