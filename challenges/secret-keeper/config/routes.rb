SecretKeeper::Application.routes.draw do
  root to: 'pages#index'
  devise_for :users, controllers: { registrations: 'registrations' }
  resources :secrets, only: [:show, :update, :edit]

  resources :users, only: [:index]
end
