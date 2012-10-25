module ApplicationHelper
  def body_class
    %Q{' class="#{controller.controller_name}"}.html_safe unless controller.controller_name.nil? || controller.controller_name.blank?
  end
end
