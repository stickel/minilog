class AddAboutBoxToAuthor < ActiveRecord::Migration
  def self.up
    add_column :people, :information, :text
    add_column :people, :information_raw, :text
  end

  def self.down
    remove_column :people, :information_raw
    remove_column :people, :information
  end
end
