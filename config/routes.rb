Rails.application.routes.draw do
  resources :accesses, only: :create
  resources :links, only: %i[index new create]

  get '*slug', to: 'accesses#new'

  root 'links#index'
end
