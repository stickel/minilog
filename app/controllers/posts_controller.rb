class PostsController < ApplicationController
  helper :site
  $page_title = Preference.get_pref('slogan') # default title
  
  def list
    $page_title = Site.site_slogan
    @posts = Post.recent(Preference.get_pref('items_on_index'))
  end
  
  def show
    @posts = Post.find_by_permalink(params[:permalink])
    $page_title = @posts.title.nil? ? '' : @posts.title
  end
  
  def archive
    
  end
  
  def by_day
    
  end
  
  def by_month
    
  end
  
  def by_year
    
  end
end
