class Site
  # meta tags
  def self.meta_tags
    meta  = '<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />'+"\n\t"
  	meta += '<meta name="viewport" content="width=device-width" />'+"\n\t"
    meta += '<meta name="Author" content="'+'something here'+'" />'+"\n\t"
	  meta += '<meta name="Description" content="'+'something here'+'" />'+"\n\t"
	  return meta
  end
  
  def self.site_linked
    return '<a href="'+Site.site_url+'" title="'+Site.site_name+'">'+Site.site_name+'</a>'
  end
  
  def self.site_name
    return Preference.get_pref('site_name')
  end
  
  def self.site_slogan
    return Preference.get_pref('slogan')
  end
  
  def self.metrics
    return Preference.get_pref('metrics')
  end
  
  def self.site_url
    url = Preference.get_pref('domain')
    return (url == '' ? '/' : "http://#{url}")
  end
  
  def self.archive_path
    return Preference.get_pref('archive_path_name')
  end
  
  def self.archive_link_format
    return Preference.get_pref('archive_link_format')
  end
  
  def self.language
    return Preference.get_pref('language')
  end
  
  def self.time_zone
    return Preference.get_pref('timezone')
  end
  
  def self.nice_month(month)
    return Time.mktime(Time.zone.now.year,month,Time.zone.now.day).to_s(:month)
  end
  
  def self.page_navigation
    # Pages can only go down one level
    parents = Page.published.parents.sorted
    list = '<ul id="page_nav">'+"\n"
    
    parents.each do |parent|
      list += '<li><a href="'+Site.site_url+'/'+parent.permalink+'" title="'+parent.title+'">'+parent.title+'</a>'
      if !(children = Page.has_children?(parent.id)).nil?
        list += "\n"+'<ul class="sub_page">'+"\n"
        list += make_page_link(children)
        list += "</ul>\n"
      end
      list += "</li>\n"
    end
    
    list += "</ul>\n"
  end
  
  def self.archive_years
    return Post.years
  end
  
  def self.archive_by_year
    posts = Post.published.years
    list  =   '<h3>Archive by year</h3>'
    if Site.archive_link_format === 'list'
      archive_start       = '<ul>'+"\n"
      archive_item_prefix = '<li>'
      archive_item_suffix = "</li>\n"
      archive_end         = '</ul>'+"\n"
    end
    
    list  +=  archive_start
    posts.each do |post|
      list  +=  archive_item_prefix+'<a href="/'+Site.archive_path+'/'+post.published_at.year.to_s+'">'+post.published_at.year.to_s+"</a>"+archive_item_suffix
    end
    list  +=  archive_end
    return list
  end
  
  def self.archive_by_month
    posts = Post.published.months
    list  =   '<h3>Archive by month</h3>'
    if Site.archive_link_format === 'list'
      archive_start       = '<ul>'+"\n"
      archive_item_prefix = '<li>'
      archive_item_suffix = "</li>\n"
      archive_end         = '</ul>'+"\n"
    end
    
    list  +=  archive_start
    posts.each do |post|
      list += archive_item_prefix+'<a href="/'+Site.archive_path+'/'+post.published_at.year.to_s+'/'+post.published_at.to_s(:month_digit)+'">'+Site.nice_month(post.published_at.month.to_s)+' '+post.published_at.year.to_s+"</a>"+archive_item_suffix
    end
    list  +=  archive_end
    return list
  end
  
  protected
  def self.make_page_link(pages)
    result = ''
    pages.each do |page|
      result += '<li><a href="'+Site.site_url+'/'+page.permalink+'" title="'+page.title+'">'+page.title+"</a></li>\n"
    end
    return result
  end
  
end

module SiteHelper
end