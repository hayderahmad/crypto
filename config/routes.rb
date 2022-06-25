Rails.application.routes.draw do
  
  root 'home#index'
  get 'home/prices'
  get 'home/show/:id', to: 'home#show'
  post 'home/create_comment/:id', to: 'home#create_comment'
  post '/home/prices', to: 'home#prices'
  get '/home/delete_comment/:article_id/:comment_id', to: 'home#delete_comment'
  get '/home/show_comment/:article_id/:comment_id', to: 'home#show_comment'
  post '/home/update_comment/:article_id/:comment_id', to: 'home#update_comment'
  
end
 