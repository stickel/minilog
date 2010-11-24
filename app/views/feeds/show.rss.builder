xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "#{Site.site_name}"
    xml.description "Syndication for posts from #{Site.site_name}"
    xml.link feed_url('posts')
    
    for post in @posts
      xml.item do
        xml.title post.title
        xml.description post.body
        xml.pubDate post.published_at.to_s(:rfc822)
        xml.link "http://#{Site.site_url}/#{Site.archive_path}/" + post.permalink
      end
    end
  end
end