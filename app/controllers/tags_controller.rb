class TagsController < ApplicationController
  helper :posts
  
  def list
    @tag = params[:tag]
    @posts = Post.published.newest_first.with_tag(@tag)
  end
end
