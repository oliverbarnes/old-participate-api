Rails.application.routes.draw do

  resources :tokens, only: :create
  resources :proposals do
    resources :suggestions, shallow: true
  end
  resources :supports
end
