# frozen_string_literal: true

module Types
  class ArticleType < Types::BaseObject
    field :id, ID, null: false
    field :title, String
    field :body, String
    field :imageurl, String
    field :source, String
    field :article_url, String
    field :article_id, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :comments, [Types::CommentType], null: true
    field :comments_count, Integer, null: true
    
    def comments_count
      object.comments.size
    end
  end

end
