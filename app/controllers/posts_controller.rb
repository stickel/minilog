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
    $page_title = 'Archived posts'
    @posts = Post.recent(Preference.get_pref('items_on_index'))
    @archive_years = Post.years
  end
  
  def by_day
    $page_title = "Archived posts for #{Site.nice_month(params[:month])} #{params[:day]}"
    @posts = Post.recent(Preference.get_pref('items_on_index'))
    @archive_years = Post.years
  end
  
  def by_month
    $page_title = "Archived posts for #{Site.nice_month(params[:month])}"
    @posts = Post.recent(Preference.get_pref('items_on_index'))
    @archive_years = Post.years
  end
  
  def by_year
    $page_title = "Archived posts for #{params[:year]}"
    @posts = Post.recent(Preference.get_pref('items_on_index'))
    @archive_years = Post.years
  end
end
