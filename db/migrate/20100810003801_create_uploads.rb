class CreateUploads < ActiveRecord::Migration
  def self.up
    create_table :uploads do |t|
      t.integer :post_id
      t.string :caption
      t.string :upload_file_name
      t.string :upload_content_type
      t.string :upload_file_size
      t.datetime :upload_updated_at
    end
  end

  def self.down
    drop_table :uploads
  end
end
