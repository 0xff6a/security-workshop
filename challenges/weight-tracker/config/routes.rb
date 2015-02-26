WeightTracker::Application.routes.draw do
  resources :entries

  resources :users, only: [:new, :edit, :create, :update]
  resources :entries, only: [:index]
  resource  :session, only: [:new, :create, :destroy]
  root :to => "home#index"
end
