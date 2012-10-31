class AddStatesToUsers < ActiveRecord::Migration
  def up
    add_column :users, :deleted_at, :datetime
    add_column :users, :suspended_at, :datetime
    add_index :users, :deleted_at
    add_index :users, :suspended_at
  end

  def down
    remove_column :users, :deleted_at
    remove_column :users, :suspended_at
  end
end
