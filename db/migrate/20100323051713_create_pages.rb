class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.column :title, :string, :limit => 128
      t.column :permalink, :string, :limit => 128
      t.column :body, :text
      t.column :body_raw, :text
      t.column :is_active, :boolean, :default => true
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end
