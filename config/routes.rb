Rails.application.routes.draw do
  namespace :v1 do
    namespace :me do
      post "sleep", to: "sleeps#create"
      post "wake_up", to: "wake_ups#create"

      get "analytics", to: "analytics#index"
      get "activities", to: "activities#index"
    end

    resources :users, only: [] do
      post "follows", to: "users/follows#create"
      delete "follows", to: "users/follows#destroy"

      get "activities", to: "users/activities#index"
    end
  end
end
