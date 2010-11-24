atom_feed :root_url => Site.site_url do |feed|
  feed.title(@title)
  feed.updated(@updated)
  
  @posts.each do |post|
    feed.entry(post, :url => post_url(Site.archive_path, post.permalink)) do |entry|
      entry.title(h(post.title))
      entry.summary(truncate_paragraphs(post.body), :type => 'html')
      entry.author do |author|
        author.name(post.person.name)
      end
    end
  end
end