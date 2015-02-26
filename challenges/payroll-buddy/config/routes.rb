PayrollBuddy::Application.routes.draw do
  root :to => "home#index"
  devise_for :users
  resources :users, only: [:show, :edit, :update]
  resources :organisations, only: [:show]
  resource :salary, only: [:update]
end
