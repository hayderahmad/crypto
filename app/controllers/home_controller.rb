class HomeController < ApplicationController
  before_action :require_signin
  def index
    require 'net/http'
    require 'json'

    @url = 'https://min-api.cryptocompare.com/data/v2/news/?lang=EN'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @news = JSON.parse(@response)
    @news['Data'].each do |recived_article|
      unless Article.exists?(article_id: recived_article['id'])  
        @article = Article.create(title: recived_article['title'], body: recived_article['body'], imageurl: recived_article['imageurl'], source: recived_article['source'], article_url: recived_article['url'], article_id: recived_article['id'])
      end
    end
    @news = Article.last(10)
    @prices_url = 'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,XRP,BCH,EOS,LTC,ADA,XLM,MIOTA,USDT,TRX&tsyms=USD'
    @prices_uri = URI(@prices_url)
    @prices_response = Net::HTTP.get(@prices_uri)
    @prices = JSON.parse(@prices_response)
  end

  def prices
    require 'net/http'
    require 'json'
    @symbol = params[:sym]
    if @symbol
      @symbol = @symbol.upcase
      @qoute_url = 'https://min-api.cryptocompare.com/data/pricemultifull?fsyms='+ @symbol +'&tsyms=USD'
      @qoute_uri = URI(@qoute_url)
      @qoute_response = Net::HTTP.get(@qoute_uri)
      @qoute = JSON.parse(@qoute_response)
    end
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
    @article = Article.find(params[:id])
    if session[:user_id]
      commenter_name = User.find(session[:user_id]).name
    else
      commenter_name = "Guest"
    end
    if @article.comments.create(commenter: commenter_name, body: params[:comment])
        redirect_to "/home/show/#{params[:id]}", allow_other_host: true
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
    
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:comment_id])
    new_like = params[:like].to_i + 1
    @comment = @comment.update(like: new_like)
    redirect_to "/home/show/#{params[:article_id]}", allow_other_host: true
  end
  def dislike
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:comment_id])
    new_dislike =  params[:dislike].to_i + 1
    @comment = @comment.update(dislike: new_dislike)
    redirect_to "/home/show/#{params[:article_id]}", allow_other_host: true
  end

end
