module PostsHelper
  
  def tags_as_sentence(tags, links = true)
    return if tags.nil?
    sentence = []
    if links
      tags.each do |t|
        sentence << link_to(t.name.strip, tags_path(t.name.strip))
      end
    else
      sentence = tags
    end
    return sentence.to_sentence
  end
  
  def tags_into_array(tags)
    return if tags.nil?
    tag_array = []
    tags.each do |t|
      tag_array << t.name
    end
    return tag_array
  end
  
  def related_posts(number_of_posts, title = "Related Posts")
    return if @posts.tags.blank?
    random_tag = @posts.tags[rand(@posts.tags.length.to_i)].name
    random_posts = Post.with_tag(random_tag, number_of_posts)
    
    if random_posts.length === 1 && random_posts[0].id === @posts.id
      return
    elsif random_posts.length >= 1
      puts random_tag
      puts random_posts.inspect
      
      related_list = "<h4 id=\"related-posts-title\">" + title + "</h4>\n"
      related_list += "<ul id=\"related-posts-list\">\n"
      random_posts.each do |p|
        next if p.id === @posts.id
        related_list += "<li class=\"related-posts\">" + link_to(p.title, post_path(Site.archive_path, p.permalink), :title => "Read '#{p.title}'") + "</li>\n"
      end
      related_list += "</ul>\n"
      return related_list
    end
  end
  
  def tweet_this
    if Site.tweet_this
      return '<a href="http://twitter.com/share" class="twitter-share-button" data-count="vertical" data-via="stickel">Tweet</a><script type="text/javascript" src="http://platform.twitter.com/widgets.js"></script>'
    end
  end
  
end
