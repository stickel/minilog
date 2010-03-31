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
  
end

module SiteHelper
end