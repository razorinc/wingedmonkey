Rails.application.routes.draw do
  root to: "dashboard#index"

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout", sign_up: "register"}

  resources :launchables

  get "providers/select"

end
