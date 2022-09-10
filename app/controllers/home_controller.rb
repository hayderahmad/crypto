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
  
  def create_comment
    article_id = params[:id]
    session_id = session[:user_id]
    article = Article.find(article_id)
    commenter_name = User.find(session_id).name
    if article.comments.create(commenter: commenter_name, body: params[:comment])
      Article.send_email(article_id, session_id)
      redirect_to "/home/show/#{article_id}", allow_other_host: true
    else
      render "/home/show/#{article_id}"
    end
    
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
  def like
    commenter = User.find(session[:user_id])
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:comment_id])
    new_like = params[:like].to_i + 1
    @comment = @comment.update(like: new_like)
    redirect_to "/home/show/#{params[:article_id]}", allow_other_host: true
    @comment = @article.comments.find(params[:comment_id])
    commenter.notification_settings.where(setting_config_type: "like_count").each do |setting|
      if @comment.like == setting.setting_config_params["count"].to_i && @comment.commenter == commenter.name
        puts "Send email to :  #{setting.user.name} the email : #{setting.user.email} the comment  #{@comment.body} has #{@comment.like} likes"
        puts AlertService.client.send_alert(EmailAlert.new(:subject => "Testing", :body => "the comment  #{@comment.body} has #{@comment.like} likes", :recipient_email=> setting.user.email))
      end
    end
  end
  def dislike
    commenter = User.find(session[:user_id])
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:comment_id])
    new_dislike =  params[:dislike].to_i + 1
    @comment = @comment.update(dislike: new_dislike)
    redirect_to "/home/show/#{params[:article_id]}", allow_other_host: true
    @comment = @article.comments.find(params[:comment_id])
    commenter.notification_settings.where(setting_config_type: "dislike_count").each do |setting|
      if @comment.dislike == setting.setting_config_params["count"].to_i && @comment.commenter == commenter.name
        puts "Send email to :  #{setting.user.name} the email : #{setting.user.email} the comment  #{@comment.body} has #{@comment.dislike} dislikes"
        puts AlertService.client.send_alert(EmailAlert.new(:subject => "Testing", :body => "the comment  #{@comment.body} has #{@comment.dislike} likes", :recipient_email=> setting.user.email))
      end
    end
  end

end
