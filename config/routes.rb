Rails.application.routes.draw do
  resources :users
  
  root 'home#index'
  get 'home/prices'
  get 'home/show/:id', to: 'home#show'
  post 'home/create_comment/:id', to: 'home#create_comment'
  post '/home/prices', to: 'home#prices'
  get '/home/delete_comment/:article_id/:comment_id', to: 'home#delete_comment'
  get '/home/show_comment/:article_id/:comment_id', to: 'home#show_comment'
  get '/home/like/:article_id/:comment_id/:like', to: 'home#like'
  get '/home/dislike/:article_id/:comment_id/:dislike', to: 'home#dislike'
  post '/home/update_comment/:article_id/:comment_id', to: 'home#update_comment'
  
  get "/users", to: 'users#index'
  get "/users/:id", to: 'users#show'
  post "/users", to: 'users#create'
  get "/users/:id/edit", to: 'users#edit'
  post "/users/:id", to: 'users#update'
  delete "/users/:id", to: 'users#destroy'
  
  get "/session/sign_in"
  post "/session", to: 'session#create'
  delete "/session", to: 'session#destroy'
  
  get "notificationsettings/new", to: 'notification_settings#new'
  post "notificationsettings/create", to: 'notification_settings#create'
  post "notificationsettings/update/:user_id", to: 'notification_settings#update'
  get "notificationsettings/edit/:user_id", to: 'notification_settings#edit'
  
  
end
 