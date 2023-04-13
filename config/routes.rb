Rails.application.routes.draw do
  namespace :v1 do
    namespace :me do
      post "sleep", to: "sleeps#create"
      post "wake_up", to: "wake_ups#create"
    end
  end
end
