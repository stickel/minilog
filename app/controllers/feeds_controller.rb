class FeedsController < ApplicationController
  def index
    $page_title = 'Feeds'
  end
  
  def show
    @site = Site.site_url
    @site_name = Site.site_name
    @post_path = Site.archive_path
    @posts = Post.published.recent(Preference.get_pref('items_in_feed'), :format => :rss)
    render :layout => false and return
  end
end
