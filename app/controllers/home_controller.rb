class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'

    @url = 'https://min-api.cryptocompare.com/data/v2/news/?lang=EN'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @news = JSON.parse(@response)
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
  
end
