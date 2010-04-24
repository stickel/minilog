class AddParentOrderToPages < ActiveRecord::Migration
  def self.up
    add_column :pages, :parent_id, :integer
    add_column :pages, :order, :integer
    add_column :pages, :in_nav, :boolean
  end

  def self.down
    remove_column :pages, :in_nav
    remove_column :pages, :order
    remove_column :pages, :parent_id
  end
end
