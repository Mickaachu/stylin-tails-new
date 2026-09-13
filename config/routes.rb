Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    root "dashboard#index"
    resources :owners do
    end
    resources :pets
    resources :appointments do
      member do
        patch :approve
        patch :reject
      end
    end
    resources :availabilities, only: %i[index create destroy]
  end
  resources :appointments
  resources :owners
  resources :pets
  get "profile" => "profile#show", as: :profile
  get "services" => "services#index", as: :services
  get "contact" => "contact#new", as: :contact
  post "contact" => "contact#create"
  resource :settings, only: %i[show update], controller: "settings"
  get "dashboard" => "dashboard#index", as: :dashboard
  get "about" => "about#index"
  get "home" => "home#index"
  root "home#index"

  get "up" => "rails/health#show", as: :rails_health_check
end
