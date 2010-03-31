class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.column :author_id, :integer, :null => false
      t.column :permalink, :string, :limit => 128
      t.column :title, :string
      t.column :summary, :text
      t.column :body, :text
      t.column :body_raw, :text
      t.column :is_active, :boolean, :default => true
      t.column :comment_status, :boolean, :default => false
      t.column :published_at, :datetime
      t.timestamps
    end
    
    Post.new(:author_id => '1',:permalink => 'test-post',:title => 'Test Post',:summary => '',:body => '<p>This is a test post. You should <a href="/admin">sign in to the admin area</a> and change your login and password. After that you can update this post, delete it, or just leave it and create another one.</p><p>There’s much more which can be done via the <a href="/admin">admin area</a>. Please explore and contact us if you have any questions.</p>',:body_raw => 'This is a test post. You should [sign in to the admin area](/admin) and change your login and password. After that you can update this post, delete it, or just leave it and create another one.'+"\n\n"+'There’s much more which can be done via the [admin area](/admin). Please explore and contact us if you have any questions.',:is_active => true,:comment_status => false,:published_at => Time.zone.now.utc.to_s(:db)).save
  end

  def self.down
    drop_table :posts
  end
end
