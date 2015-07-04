Rails.application.routes.draw do

  resources :tokens, only: :create
  resources :proposals do
    resources :supports, shallow: true, only: [:create, :destroy]
    resources :suggestions, shallow: true
  end
end
