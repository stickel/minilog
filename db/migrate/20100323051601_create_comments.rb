class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.column :post_id, :integer
      t.column :name, :string
      t.column :email, :string
      t.column :url, :string
      t.column :comment, :text
      t.column :comment_raw, :text
      t.column :ip, :string
      t.column :is_approved, :boolean, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
