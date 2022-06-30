class AddOpinionToComments < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :like, :integer, default: 0
    add_column :comments, :dislike, :integer, default: 0
  end
end
