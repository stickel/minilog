module PagesHelper
  def page_title(id)
    if Page.find_by_id(id)
      return page.title
    else
      return 'None'
    end
  end
end
