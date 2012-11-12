Rails.application.routes.draw do
  root to: "dashboard#index"

  devise_for :users, path_names: {sign_in: "login", sign_out: "logout", sign_up: "register"}

  resources :launchables

  get "providers/select"

  # get "dashboard/index"

  get "dashboard/choose_provider"

  # get "launch/list"

  # get "launch/index"

  # post "launch/launch"

  # get "launch/start"

  # get "launch/stop"

  # get "launch/pause"

  # get "launch/resume"

  # get "launch/restart"

  # get "launch/snapshot"

  # get "launch/clone"
end
