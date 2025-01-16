Rails.application.routes.draw do
  devise_for :users
  get "dashboard/index"

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA dynamic routes
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Root route
  root "podcasts#search"

  # Podcasts search route
  get "/podcasts", to: "podcasts#search"

  # Podcasts resources
  resources :podcasts do
    # Custom collection routes
    collection do
      get :search
    end

    # Custom member routes
    member do
      post :favorite  
      delete :unfavorite
      patch :played
      patch :unplayed
      patch :finished
      patch :unfinished
    end

    # Nested feedbacks resource
    resources :feedbacks, only: [:create, :edit, :update, :destroy] # Restrict to necessary actions
  end
end
