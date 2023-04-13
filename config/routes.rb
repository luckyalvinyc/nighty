Rails.application.routes.draw do
  namespace :v1 do
    namespace :me do
      post "sleep", to: "sleeps#create"
      post "wake_up", to: "wake_ups#create"
    end

    resources :users, only: [] do
      post "follows", to: "users/follows#create"
      delete "follows", to: "users/follows#destroy"
    end
  end
end
