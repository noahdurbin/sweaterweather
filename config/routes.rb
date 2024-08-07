Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create]

      post '/sessions', to: 'users#login'
      get '/forecast', to: 'weather#forecast'
      post '/road_trip', to: 'road_trips#create'
    end
  end
end
