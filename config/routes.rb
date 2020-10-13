Rails.application.routes.draw do
  get 'download/new'
  devise_for :users
  resources :links, only: %i[index new create]
  resource :download, only: :new

  get '*slug', to: 'accesses#new'

  root 'links#index'
end
