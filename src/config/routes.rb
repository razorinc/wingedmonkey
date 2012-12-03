Rails.application.routes.draw do
  root to: "provider_applications#index"

  resources :launchables
  resources :provider_applications

  match 'login',       :to => 'sessions#new',     :as => 'login'
  match 'logout',      :to => 'sessions#destroy', :as => 'logout'
  resources :sessions

  post "providers/select"

end
