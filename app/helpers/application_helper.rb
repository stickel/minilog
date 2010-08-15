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
  
end