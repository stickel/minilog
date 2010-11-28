# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

require 'preference'

class ApplicationController < ActionController::Base
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  include AuthenticatedSystem
  # layout 'site'
  layout 'default'
  theme :get_theme
  helper :site # include all helpers, all the time
  helper_method :htmlize_copy, :list_to_array, :make_permalink, :tags_to_list
  before_filter :set_time_zone
  
  def get_theme
    return 'healthierme'
    # return Preference.get_pref('theme_name')
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
    # e.g., {{image /image/uploads/image_name.jpg 'alt text' 'class_name' 'id_name'}}
    regex_pattern = /([\{]{2})([\s]{0,1})([a-zA-Z]+\s)(.*)([\s]{0,1})([}]{2})/
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
        image_bits = match[3].split(', ')
        # image_name = image_bits[0]
        # alt_text = image_bits[1]
        # class_names = image_bits[2]
        # id_name = image_bits[3]
        if image_bits[3].nil?
          image_tag = build_image_tag(image_bits[0], image_bits[1], image_bits[2])
        else
          image_tag = build_image_tag(image_bits[0], image_bits[1], image_bits[2], image_bits[3])
        end
        replace_strings << image_tag
      end
      # TODO: other template tag types
    end
    new_content = content
    unless replace_strings.empty?
      for match in match_strings
        new_content = new_content.gsub(match_strings[index], replace_strings[index])
        index += 1
      end
    else
      new_content = content
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
  def build_image_tag(image, alt_text, class_name=nil, id_name=nil)
    image_tag = '<img src="'
    if image.split('/').size > 1
      image_tag += image
    else
      image_tag += '/images/uploads/' + image
    end
    image_tag += '"'
    image_tag += ' alt="'
    image_tag += alt_text unless alt_text.match("''")
    image_tag += '"' 
    image_tag += ' class="' + class_name + '"' unless class_name.nil?
    image_tag += ' id="' + id_name + '"' unless id_name.nil?
    image_tag += " />"
    return image_tag
  end
end

class Helper
  include Singleton
  include ActionView::Helpers::TextHelper
end