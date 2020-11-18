Rails.application.routes.draw do
  resources :links, only: %i[index create show destroy], defaults: {format: :json}
  resource :downloads, only: :new
  resources :sessions, only: :create
  resources :registrations, only: :create

  delete :logout, to: 'sessions#logout'
  get :logged_in, to: 'sessions#logged_in'

  get '*slug', to: 'accesses#show'

  root 'links#index'
end
