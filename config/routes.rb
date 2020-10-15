Rails.application.routes.draw do
  devise_for :users
  resources :links, only: %i[index new create]
  resource :downloads, only: :new

  get '*slug', to: 'accesses#new'

  root 'links#index'
end
