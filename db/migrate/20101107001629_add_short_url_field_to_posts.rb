class AddShortUrlFieldToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :short_url, :string
    
    # update the short_urls
    posts = Post.all
    posts.each do |p|
      if p.update_attribute(:short_url, p.id.to_s(36))
        puts "Post updated. ID: #{p.id}, Short: #{p.short_url}"
      else
        puts "Couldn’t update post.id #{p.id}"
      end
    end
  end

  def self.down
    remove_column :posts, :short_url
  end
end
