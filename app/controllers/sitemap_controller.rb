class SitemapController < ApplicationController
  def index
    @posts = Post.published.limited_set(50000)
    respond_to do |wants|
      wants.xml { render :layout => false }
    end
  end
end
