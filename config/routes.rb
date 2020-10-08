Rails.application.routes.draw do
  devise_for :users
  resources :accesses, only: :create
  resources :links, only: %i[index new create] do
    get 'download', on: :collection
  end

  get '*slug', to: 'accesses#new'

  root 'links#index'
end
