class Admin::BaseController < ApplicationController
  layout 'admin'
  before_filter :login_required
  
  def index
    $page_title = 'Admin'
  end
  
  protected
    def check_admin_creds
      
    end
end
