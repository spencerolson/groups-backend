Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :messages, only: [:index]
  resources :users, only: [:index, :create] do
    post "add_message"
    post "logout"
  end

  mount ActionCable.server => "/cable"
end
