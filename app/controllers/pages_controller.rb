class PagesController < ApplicationController
  def show
    @pages = Page.find_by_permalink(params[:permalink])
    $page_title = @pages.title
  end
end
