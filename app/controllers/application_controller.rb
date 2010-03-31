# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

require 'preference'

class ApplicationController < ActionController::Base
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  include AuthenticatedSystem
  layout 'site'
  helper :site # include all helpers, all the time
end
