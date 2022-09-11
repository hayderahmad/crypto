class HomeController < ApplicationController
  
  before_action :require_signin
  def index
    Article.update_news
    @news = Article.last(20)
    @prices = Article.get_prices
  end

  def prices
    @symbol = params[:sym]
    @qoute = Article.get_qoute(@symbol)
  end

  def show
    @article = Article.find(params[:id])
  end
  
  def delete_comment
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:comment_id])
    @comment.destroy
    redirect_to "/home/show/#{@article[:id]}", allow_other_host: true
  end
  def show_comment
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:comment_id])
  end
  def update_comment
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:comment_id])
    if @article.comments.update(body: params[:comment])
      redirect_to "/home/show/#{params[:article_id]}", allow_other_host: true
    end
  end
  
  def create_comment
    article_id = params[:id]
    article = Article.find(article_id)
    user= User.find(session[:user_id])
    config_type = "comment_count"
    if article.comments.create(commenter: user.name, body: params[:comment])
      redirect_to "/home/show/#{article_id}", allow_other_host: true
      Article.notification_email(article, config_type)
    else
      render "/home/show/#{article_id}"
    end
    
  end
  def like
    article = Article.find(params[:article_id])
    comment = article.comments.find(params[:comment_id])
    comment.update(like: params[:like].to_i + 1)
    redirect_to "/home/show/#{params[:article_id]}", allow_other_host: true
    config_type = "like_count"
    Article.notification_email(article, config_type, comment)
    
    # user.notification_settings.where(setting_config_type: "like_count").each do |setting|
    #   if @comment.like == setting.setting_config_params["count"].to_i && @comment.commenter == commenter.name
    
    #   end
    # end
  end
  def dislike
    article = Article.find(params[:article_id])
    comment = article.comments.find(params[:comment_id])
    comment.update(dislike: params[:dislike].to_i + 1)
    redirect_to "/home/show/#{params[:article_id]}", allow_other_host: true
    config_type = "dislike_count"
    Article.notification_email(article, config_type, comment)
    
    # commenter.notification_settings.where(setting_config_type: "dislike_count").each do |setting|
    #   if @comment.dislike == setting.setting_config_params["count"].to_i && @comment.commenter == commenter.name
        
    #   end
    # end
  end
  

end
