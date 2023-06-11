Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  mount ActionCable.server => '/cable'
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      post '/login', to: 'sessions#create'
      delete '/logout', to: 'sessions#destroy'
      post '/refresh_token', to: 'sessions#refresh_token'
      post '/validation_token', to: 'sessions#validation_token'

      resources :videos, only: [:index]
      post '/videos/shared_video', to: 'videos#shared'
      post '/videos/like', to: 'videos#like'
      post '/videos/dislike', to: 'videos#dislike'
    end
  end
end
