ProjectAmazing::Application.routes.draw do
  resources :tasks

  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  root to: 'tasks#index'

  get '/admin' => 'admin#index'
end
