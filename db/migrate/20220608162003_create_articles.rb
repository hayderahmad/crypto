class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :body
      t.string :imageurl
      t.string :source
      t.string :article_url
      t.string :article_id

      t.timestamps
    end
  end
end
