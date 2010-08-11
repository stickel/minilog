module PagesHelper
  def page_title(id)
    page = Page.find_by_id(id)
    unless page.nil?
      return page.title
    end
  end
end
