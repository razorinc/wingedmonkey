Rails.application.routes.draw do
  root to: "provider_applications#index"

  resources :launchables
  resources :provider_applications
  resources :sessions

  get "providers/select"

end
