class PostsController < ApplicationController
  # helper :site
  $page_title = Preference.get_pref('slogan') # default title
  
  def home
    @posts = Post.published.recent(Preference.get_pref('items_on_index'))
  end
  
  def list
    $page_title = Site.site_slogan
    @posts = Post.published.recent(Preference.get_pref('items_on_index'))
  end
  
  def show
    @posts = Post.find_by_permalink(params[:permalink])
    $page_title = @posts.title.nil? ? '' : @posts.title
  end
  
  def archive
    # TODO: Group post list by year? month? day?
    $page_title = 'Archived posts'
    @total_pages = Post.all.size
    
    # Pagination
    if params[:offset]
      offset = (Site.number_of_posts.to_i * (params[:offset].to_i - 1)).floor
      @posts = Post.published.limited_set(offset)
    else
      @posts = Post.published.recent(Site.number_of_posts)
    end
    @archive_years = Post.years
  end
  
  def by_day
    $page_title = "Archived posts for #{Site.nice_month(params[:month])} #{params[:day]}"
    @posts = Post.published.time_period(DateTime.new(params[:year].to_i, params[:month].to_i, params[:day].to_i).beginning_of_day.utc, DateTime.new(params[:year].to_i, params[:month].to_i, params[:day].to_i).end_of_day.utc)
    @archive_years = Post.years
  end
  
  def by_month
    $page_title = "Archived posts for #{Site.nice_month(params[:month])}"
    @posts = Post.published.time_period(DateTime.new(params[:year].to_i, params[:month].to_i).beginning_of_month.utc, DateTime.new(params[:year].to_i, params[:month].to_i).end_of_month.utc)
    @archive_years = Post.years
  end
  
  def by_year
    $page_title = "Archived posts for #{params[:year]}"
    @posts = Post.published.time_period(DateTime.new(params[:year].to_i).beginning_of_year.utc, DateTime.new(params[:year].to_i).end_of_year.utc)
    @archive_years = Post.years
  end
  
  def short_url
    p = Post.find_by_short_url(params[:short_url_code])
    redirect_to post_path(Site.archive_path, p.permalink)
  end
end