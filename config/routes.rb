Rails.application.routes.draw do
  
  root 'home#index'
  get 'home/prices'
  get 'home/show/:id', to: 'home#show'
 
  post '/home/prices', to: 'home#prices'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
