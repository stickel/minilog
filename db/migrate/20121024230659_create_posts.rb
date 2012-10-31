class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body, null: false
      t.string :url, null: false
      t.integer :state, default: 0
      t.integer :visibility, default: 1
      t.datetime :published_at
      t.datetime :deleted_at
      t.timestamps
    end
    add_index :posts, :url
  end
end
