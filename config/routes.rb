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


  get "/dashboard", to: "users#show", as: :dashboard
  # get "/redirect", to: "omniauth_callbacks#calendar", as: :redirect
  # get "/callback", to: "omniauth_callbacks#callback", as: :callback
end
