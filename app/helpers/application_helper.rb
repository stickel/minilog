# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def sign_in_out_link(person)
    if person.nil?
      return link_to 'Sign in', login_path
    else
      return link_to 'Sign out', logout_path
    end
  end
  
end