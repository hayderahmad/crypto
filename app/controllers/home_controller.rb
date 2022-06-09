class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'

    @url = 'https://min-api.cryptocompare.com/data/v2/news/?lang=EN'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @news = JSON.parse(@response)
    @news['Data'].each do |recived_article|
      unless Article.exists?(article_id: recived_article['id'])  
        @article = Article.new(title: recived_article['title'], body: recived_article['body'], imageurl: recived_article['imageurl'], source: recived_article['source'], article_url: recived_article['url'], article_id: recived_article['id'])
        @article.save
      end
    end
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
    @article = Article.find_by(article_id: params[:id])
  end
  
end
