Rails.application.routes.draw do
  root "users#index"
  devise_for :users
  devise_for :models
  get 'users/index'
  resources :users
  match '/users',   to: 'users#index',   via: 'get'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope "/rooms" do
    post "/create", to: "rooms#create"
    get "/:id", to: "rooms#show"
  end
  scope "/messages" do
    post "/create", to: "messages#create"
  end
  root "rooms#index"
end
