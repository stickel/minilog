class Admin::PostsController < ApplicationController
  layout 'admin'
  before_filter :login_required
  helper :application
  
  def index
    $page_title = 'Manage posts'
    @posts = Post.recent(20)
  end
  
  def new
    $page_title = 'Write a new post'
    @post = Post.new
  end
  
  def create
    post = Post.new(params[:post])
    post.permalink = params[:post][:permalink].nil? ? params[:post][:permalink] : make_permalink(params[:post][:title])
    post.body = htmlize_copy(params[:post][:body_raw])
    post.author_id = current_person.id
    post.published_at = params[:post][:published_at] ? Time.zone.parse(params[:post][:published_at]).utc : Time.zone.now.utc
    if post.save
      unless params[:tags].blank? || params[:tags].empty?
        post_tags = []
        tags = list_to_array(params[:tags])
        tags.each do |t|
          post_tags << Tag.find_or_create_by_name(t)
        end
        post.tags = post_tags
      end
      flash[:notice] = "Post created"
      redirect_to admin_posts_path
    else
      flash[:error] = "Error creating post. Please try again."
      render :action => :new
    end
  end
  
  def edit
    $page_title = 'Edit post'
    @post = Post.find(params[:id])
    @tags = tags_to_list(@post.tags)
    @return_path = request.referrer
  end
  
  def update
    post = Post.find(params[:id])
    post.permalink = params[:post][:permalink].nil? ? params[:post][:permalink] : make_permalink(params[:post][:title])
    post.body = htmlize_copy(params[:post][:body_raw])
    post.published_at = Time.zone.parse(params[:post][:published_at]).utc
    if post.update_attributes(params[:post])
      unless params[:tags].blank? || params[:tags].empty?
        post_tags = []
        tags = list_to_array(params[:tags])
        tags.each do |t|
          post_tags<< Tag.find_or_create_by_name(t)
        end
        post.tags = post_tags
      end
      flash[:notice] = "Post updated!"
      redirect_to params[:return_path]
      # render :action => :edit
    else
      flash[:error] = "Error updating post. Please try again."
      render :action => :edit
    end
  end
  
  def list
    @posts = Post.all
  end
end
