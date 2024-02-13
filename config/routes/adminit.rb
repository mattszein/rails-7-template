# Below are the routes for madmin
namespace :adminit do
  resources :roles, only: [:index, :show] do
    collection do
      get "user_select"
    end
    delete "user", to: "roles#remove_user", on: :member

    post "user", to: "roles#add_user", on: :member
  end
  resources :permissions, only: [:index] do
    put "/", to: "permissions#update", on: :member
  end
  resources :dashboard, only: [:index]
  root to: "dashboard#index"
end
