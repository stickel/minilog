class FeedsController < ApplicationController
  def index
    $page_title = 'Feeds'
  end
  
  def show
    respond_to do |format|
      format.rss do
        @site = Site.site_url
        @site_name = Site.site_name
        @post_path = Site.archive_path
        @posts = Post.published.recent(Preference.get_pref('items_in_feed'), :format => :rss) 
      end
      format.atom do
        @posts = Post.published.recent(Preference.get_pref('items_in_feed'))
        @title = "#{Site.site_name} Feed"
        @updated = @posts.first.published_at unless @posts.empty?
      end
    end
  end
end
