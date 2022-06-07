Rails.application.routes.draw do
  
  root 'home#index'
  get 'home/prices'
  post "/home/prices" => 'home/prices'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
