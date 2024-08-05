Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[create]

      get '/book-search', to: 'book#search'
      post '/sessions', to: 'users#login'
      get '/forecast', to: 'weather#forecast'
    end
  end
end
