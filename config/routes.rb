Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      post '/login', to: 'sessions#create'
      delete '/logout', to: 'sessions#destroy'
      post '/refresh_token', to: 'sessions#refresh_token'

      resources :videos, only: [:index]
      post '/videos/shared_video', to: 'videos#shared'
    end
  end
end
