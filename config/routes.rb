require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks',
                                    sessions: 'users/sessions',
                                    registrations: "users/registrations",
                                    passwords: "users/passwords" }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "welcome#index"
  get '/user' => "users#show", :as => :user_root

  get "/dashboard", to: "users#show", as: :dashboard
  get "/loading", to: "users#index", as: :loading
  get "/google_slides", to: "google_slides#show", as: :google_slides
  get "/demo/:mod", to: "demo#show", as: :demo

  mount Sidekiq::Web => "/sidekiq"
  # mount ActionCable.server => '/cable'
end
