Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:create, :index, :update]
  resources :auth, only: [:create]

  get '/login', to: 'users#profile'
  get '/upload', to: '
end
