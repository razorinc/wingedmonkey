Rails.application.routes.draw do
  root to: "provider_applications#index"

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout", sign_up: "register"}

  resources :launchables
  resources :provider_applications
  resources :sessions

  get "providers/select"

end
