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
  
  def self.nice_month(month)
    return Time.mktime(Time.zone.now.year,month,Time.zone.now.day).to_s(:month)
  end
  
  def self.archive_years
    return Post.years
  end
  
  def self.archive_by_year
    years = Post.years
    list  =   '<h3>Archive by year</h3>'
    list  +=  '<ul>'+"\n"
    years.group_by(&:year).each do |y|
      list  +=  '<li><a href="/'+Site.archive_path+'/'+y[0]+'">'+y[0]+"</a></li>\n"
    end
    list  +=  '</ul>'+"\n"
    return list
  end
  
  # FIXME: Group this by month/year
  def self.archive_by_month
    months = Post.months
    list  =   '<h3>Archive by month</h3>'
    list  +=  '<ul>'+"\n"
    months.each do |m|
      # return year
      # list  +=  '<li><a href="/'+Site.archive_path+'/'+year[0]+'/'+month[0]+'">'+Site.nice_month(month[0])+' '+year[0]+"</a></li>\n"
      list  +=  '<li><a href="/'+Site.archive_path+'/'+m.year+'/'+m.month+'">'+Site.nice_month(m.month)+' '+m.year+"</a></li>\n"
    end
    list  +=  '</ul>'+"\n"
    return list
  end
  
end

module SiteHelper
end