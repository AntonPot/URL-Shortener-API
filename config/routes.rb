Rails.application.routes.draw do
  devise_for :users
  resources :links, only: %i[index new create show destroy]
  resource :downloads, only: :new

  get '*slug', to: 'accesses#show'

  root 'links#index'
end
