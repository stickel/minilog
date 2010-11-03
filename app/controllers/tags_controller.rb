class TagsController < ApplicationController
  helper :posts
  
  def list
    @tag = params[:tag]
    @posts = Post.with_tag(@tag)
  end
end
