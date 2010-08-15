# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

require 'preference'

class ApplicationController < ActionController::Base
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  include AuthenticatedSystem
  layout 'site'
  helper :site # include all helpers, all the time
  helper_method :htmlize_copy, :list_to_array, :make_permalink, :tags_to_list
  before_filter :set_time_zone
  
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
      return text.downcase
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
  
  def set_time_zone
    time_zone = Preference.get_pref('timezone')
    if current_person && !time_zone.blank?
      Time.zone = time_zone
    else
      Time.zone = 'UTC'
    end
  end
  
  def template_filter(content)
    regex_pattern = /([\{]{2})([\s]{0,1})([a-zA-Z]+\s)(.*)([\s]{0,1})([}]{2})/
    # regex_pattern = /([\{]{2})([\s]{0,1})([a-zA-Z]+\s)([a-zA-Z0-9\-\_\.]+)(.*)([\s]{0,1})([}]{2})/
    index = 0
    new_content = ''
    match_strings = []
    replace_strings = []
    # scan the content for tags
    content.scan(regex_pattern) do |match|
      match_strings << match.to_s
      tag_type = match[2].strip
      # images
      if tag_type == 'image'
        image_bits = match[3]
        image_name = match[3].match(/([a-zA-Z0-9\-\_\.]+)/)[0]
        attributes = match[3].sub(image_name,'').split(', ')
        alt_text = attributes[0].lstrip
        class_names = attributes[1]
        id_name = attributes[2].strip if !attributes[2].blank?
        image_tag = build_image_tag(image_name, alt_text, class_names, id_name)
        replace_strings << image_tag
      end
      # TODO: other template tag types
    end
    match_strings.each do |match|
      new_content = content.sub(match, replace_strings[index])
      index += 1
    end
    return new_content
  end
  
  def htmlize_copy(copy)
    begin
      htmlized = BlueCloth.new(copy).to_html
    rescue
      htmlized = copy
    end
    return htmlized
  end
  
  protected
  def build_image_tag(image, alt_text, class_name, id_name)
    image_tag = '<img src="/images/uploads/' + image + '"'
    image_tag += ' alt="'
    image_tag += alt_text unless alt_text.match("''")
    image_tag += '"' 
    image_tag += ' class="' + class_name + '"' unless class_name.nil?
    image_tag += ' id="' + id_name + '"' unless id_name.nil?
    image_tag += ' />'
    return image_tag
  end
end

class Helper
  include Singleton
  include ActionView::Helpers::TextHelper
end