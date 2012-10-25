class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body, null: false
      t.string :url, null: false

      t.timestamps
    end
    add_index :posts, :url
  end
end
