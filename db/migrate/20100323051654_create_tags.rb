class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.column :name, :string
    end
    create_table :posts_tags, :id => false, :force => true do |t|
      t.column :post_id, :integer
      t.column :tag_id, :integer
    end
  end

  def self.down
    drop_table :posts_tags
    drop_table :tags
  end
end
