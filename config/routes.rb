Rails.application.routes.draw do

  resources :tokens, only: :create
  resources :proposals
end
