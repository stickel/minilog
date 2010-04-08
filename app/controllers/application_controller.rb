# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

require 'preference'

class ApplicationController < ActionController::Base
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  include AuthenticatedSystem
  layout 'site'
  helper :site # include all helpers, all the time
  helper_method :htmlize_copy, :list_to_array, :make_permalink, :tags_to_list
  
  def htmlize_copy(copy)
    begin
      htmlized = BlueCloth.new(copy).to_html
    rescue
      htmlized = copy
    end
    return htmlized
  end
  
  def list_to_array(list)
    unless list.blank?
      items = []
      list.strip.downcase.split(',').each do |t|
        items << t
      end
    end
    return items
  end
  
  def make_permalink(text)
    unless text.blank? || text.empty?
      text.gsub(' ','-')
      text.gsub('\'','')
      text.gsub('"','')
      text.gsub('’','')
      return text
    end
  end
  
  def tags_to_list(tags)
    list = []
    tags.each do |t|
      list << t.name
    end
    return list.join(',')
  end
  
  def help
    Helper.instance
  end
end

class Helper
  include Singleton
  include ActionView::Helpers::TextHelper
end