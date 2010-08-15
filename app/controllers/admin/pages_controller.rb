class Admin::PagesController < ApplicationController
  layout 'admin'
  before_filter :login_required
  helper :all
  
  def index
    $page_title = 'Manage pages'
    @pages = Page.all
  end
  
  def new
    $page_title = 'Create a new page'
    $page_id = 'new_page'
    @page = Page.new
    # 2.times { @page.uploads.build }
  end
  
  def create
    page = Page.new(params[:page])
    page.permalink = params[:page][:permalink].nil? ? params[:page][:permalink] : make_permalink(params[:page][:title])
    page.body = htmlize_copy(template_filter(params[:page][:body_raw]))
    if page.save
      flash[:notice] = "Page created!"
      redirect_to admin_pages_path
    else
      flash[:error] = "Error creating page. Please try again"
      render :action => :new
    end
  end
  
  def edit
    $page_title = 'Edit page'
    @page = Page.find(params[:id])
    # 2.times { @page.uploads.build }
    @return_path = request.referrer
  end
  
  def update
    page = Page.find(params[:id])
    page.permalink = params[:page][:permalink].nil? ? params[:page][:permalink] : make_permalink(params[:page][:title])
    page.body = htmlize_copy(template_filter(params[:page][:body_raw]))
    if page.update_attributes(params[:page])
      flash[:notice] = "Page updated!"
      redirect_to params[:return_path]
    else
      flash[:error] = "Error updated page. Please try again."
      render :action => :edit
    end
  end
  
  def list
    @pages = Page.all
  end
  
  def destroy
    if Page.delete(params[:id])
      flash[:notice] = "Page deleted!"
      redirect_to :back
    else
      flash[:error] = "Problem deleting page. Please try again."
      render :action => :edit
    end
  end
end
