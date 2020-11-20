Rails.application.routes.draw do
  defaults format: :json do
    resources :registrations, only: :create
    resources :links, only: %i[index create show destroy]
    post :login, to: 'sessions#create'
    delete :logout, to: 'sessions#logout'
    get :logged_in, to: 'sessions#logged_in'
  end
  
  
  resource :downloads, only: :new
  
  get '*slug', to: 'accesses#show', defaults: {format: :json}

  root 'links#index'
end
