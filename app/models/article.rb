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
    def self.notification_email(article, config_type, comment= nil)
        NotificationSetting.where(setting_config_type: config_type).each do |setting|
            user = setting.user                    
            set_target = setting.setting_config_params["count"].to_i
            case config_type
                when "comment_count"
                    if article.comments.count == set_target
                        mail_gun(article, set_target, user, config_type)
                        
                    end
                when "like_count"
                    if comment.like == set_target
                        mail_gun(article, set_target, user, config_type)
                    end
                when "dislike_count"
                    if comment.dislike == set_target
                        mail_gun(article, set_target, user, config_type)
                    end
            end
            
        end
                
    end
    def self.mail_gun(article, set_target, user, config_type)
        require 'mailgun-ruby'
        # First, instantiate the Mailgun Client with your API key
        mg_client = Mailgun::Client.new Rails.application.credentials.config[:mailgun][:api_key]

        # Define your message parameters
        message_params =  { from: "support@#{Rails.application.credentials.config[:mailgun][:mydomain]}",
                            to:   user.email,
                            subject: 'Crypto News Notification',
                            text:    " The number of #{config_type} for the article:

                            #{article.title}
                            
                            has reached #{set_target}"
                            }

        # Send your message through the client
        mg_client.send_message Rails.application.credentials.config[:mailgun][:mydomain], message_params
    end
end