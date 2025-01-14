Rails.application.routes.draw do
  devise_for :users
  get "dashboard/index"

  # authenticated :user do
  #   root 'dashboard#index', as: :authenticated_root
  # end

  # devise_scope :user do
  #   root 'devise/sessions#new'
  # end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "podcasts#search"

  get "/podcasts", to: "podcasts#search"

  resources :podcasts do
    collection do
      get :search  # Keeps your existing search route
    end

    member do
      post :favorite  
      delete :unfavorite
    end
    
    resources :feedbacks
  # Nests feedbacks under podcasts
  end
end