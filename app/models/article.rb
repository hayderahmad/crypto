class Article < ApplicationRecord
    has_many :comments
    validates :title, presence: true
    validates :body, presence: true
    validates :imageurl, presence: true
    validates :source, presence: true
    validates :article_url, presence: true
    validates :article_id, presence: true

    

    def self.update_news
        require 'net/http'
        require 'json'
        
        url = 'https://min-api.cryptocompare.com/data/v2/news/?lang=EN'
        uri = URI(url)
        response = Net::HTTP.get(uri)
        news = JSON.parse(response)
        news['Data'].each do |recived_article|
            unless Article.exists?(article_id: recived_article['id'])  
                Article.create(title: recived_article['title'], body: recived_article['body'], imageurl: recived_article['imageurl'], source: recived_article['source'], article_url: recived_article['url'], article_id: recived_article['id'])
            end
        end
               
    end
    def self.get_prices
        prices_url = 'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,XRP,BCH,EOS,LTC,ADA,XLM,MIOTA,USDT,TRX&tsyms=USD'
        prices_uri = URI(prices_url)
        prices_response = Net::HTTP.get(prices_uri)
        JSON.parse(prices_response)
    end
    def self.get_qoute(symbol)
        require 'net/http'
        require 'json'
        if symbol
            symbol = symbol.upcase
            qoute_url = 'https://min-api.cryptocompare.com/data/pricemultifull?fsyms='+ symbol +'&tsyms=USD'
            qoute_uri = URI(qoute_url)
            qoute_response = Net::HTTP.get(qoute_uri)
            JSON.parse(qoute_response)
        end
    end
    def self.send_email(article_id, session_id)
        article = Article.find(article_id)
        commenter_name = User.find(session_id).name
        user = User.find(session_id)
        unless user.notification_settings.count == 0
            NotificationSetting.where(setting_config_type: "comment_count").each do |setting|
                set_target = setting.setting_config_params["count"].to_i
                if article.comments.count == set_target
                    
                    require 'mailgun-ruby'
                    # First, instantiate the Mailgun Client with your API key
                    mg_client = Mailgun::Client.new Rails.application.credentials.config[:mailgun][:api_key]

                    # Define your message parameters
                    message_params =  { from: "support@#{Rails.application.credentials.config[:mailgun][:mydomain]}",
                                        to:   user.email,
                                        subject: 'Crypto News Notification',
                                        text:    " The number of comments for the article:

                                        #{article.title}
                                        
                                        has reached #{set_target}"
                                        }

                    # Send your message through the client
                    mg_client.send_message Rails.application.credentials.config[:mailgun][:mydomain], message_params
                    
                end
            end
        end
                
    end
end