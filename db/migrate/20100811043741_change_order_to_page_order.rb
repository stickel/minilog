class ChangeOrderToPageOrder < ActiveRecord::Migration
  def self.up
    rename_column :pages, :order, :page_order
  end

  def self.down
    rename_column :pages, :page_order, :order
  end
end
