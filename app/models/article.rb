class Article < ApplicationRecord
    has_many :comments
    validates :title, presence: true
    validates :body, presence: true
    validates :imageurl, presence: true
    validates :source, presence: true
    validates :article_url, presence: true
    validates :article_id, presence: true
end
