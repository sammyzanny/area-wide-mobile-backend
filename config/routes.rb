Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:create, :index, :update]
  resources :auth, only: [:create]
  resources :posts, only: [:create]
  get '/login', to: 'users#profile'
  post '/forgotpassword', to: 'passwords#forgot'
  post '/resetpassword', to: 'passwords#reset'
end
