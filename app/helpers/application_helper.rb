# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def link_to_remove_fields(name, f, classname)
    f.hidden_field(:_delete) + link_to_function(name, 'remove_fields(this)', :class => classname)
  end
  
  def link_to_add_fields(name, f, association, classname)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize, :f => builder)
    end
    link_to_function(name, h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"), :class => classname)
  end
  
  def sign_in_out_link(person)
    if person.nil?
      return link_to 'Sign in', login_path
    else
      return link_to 'Sign out', logout_path
    end
  end
  
  def truncate_words(text, length = 30, end_string = '…')
    return if text.nil?
    words = text.split()
    words[0..(length - 1)].join(' ') + (words.length > length ? end_string : '')
  end
  
  def scrub_images(source)
    return if source.nil?
    source.gsub(/(<img)(.*)( \/>)/i, '')
  end
  
  def paginate(page,total_items,limit,target,previous_label,next_label)
    page = page.to_i ||= 1
    limit = limit.to_i ||= 10
    previous_label = previous_label ||= 'Previous page'
    next_label = next_label ||= 'Next page'
    target = target ||= ''
    
    previous_page = page - 1
    next_page = page + 1
    last_page = (total_items/limit).ceil
    
    # Conditional to show page navigation
    pagination = ''
    if page < last_page
      pagination << link_to("#{next_label}", "#{target}/page/#{next_page}", :class => 'next_link')
    end
    if page > 1
      pagination << link_to("#{previous_label}", "#{target}/page/#{previous_page}", :class => 'previous_link')
    end
    
    return pagination
  end
  
end