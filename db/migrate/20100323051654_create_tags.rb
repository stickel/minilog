class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.column :name, :string
    end
    create_table :tags_posts, :id => false, :force => true do |t|
      t.column :tag_id, :integer
      t.column :post_id, :integer
    end
  end

  def self.down
    drop_table :tags_posts
    drop_table :tags
  end
end
