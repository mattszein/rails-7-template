Rails.application.routes.draw do
  draw :adminit
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  root "home#index"
  get "/" => "home#index"
  get "/policies" => "users#policies", :as => :policies

  resources :users, only: [:new, :create]
  passwordless_for :users
  get "dashboard" => "dashboard#index", :as => :dashboard

  if Rails.env.development?
    mount Lookbook::Engine, at: "/lookbook"
  end

  match "*unmatched", to: "application#route_not_found", via: :all
end
