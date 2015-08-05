Rails.application.routes.draw do

  get '/me', to: 'me#show'

  resources :tokens, only: :create
  resources :proposals do
    resources :supports, shallow: true, only: [:create, :destroy]
    resources :suggestions, shallow: true
  end
  resources :supports, only: [:index]
end
