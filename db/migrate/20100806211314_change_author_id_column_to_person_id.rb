class ChangeAuthorIdColumnToPersonId < ActiveRecord::Migration
  def self.up
    rename_column :posts, :author_id, :person_id
  end

  def self.down
    rename_column :posts, :person_id, :author_id
  end
end
