class Post < ActiveRecord::Base
  validates_presence_of :permalink, :title, :body_raw
  has_permalink :permalink, :unique => true
  
  named_scope :author, lambda { |a| {:conditions => ['is_active = ? AND author_id = ? AND published_at <= ?',true,a,Time.zone.now], :order => 'published_at DESC'} }
  named_scope :time_period, lambda { |dstart,dend| {:conditions => ['is_active = ? AND published_at BETWEEN ? AND ?',dstart,dend]} }
  named_scope :recent, lambda { |*n| {:conditions => ['is_active = ? AND published_at <= ?',true,Time.zone.now], :order => 'published_at DESC', :limit => (n.first || 5)} }
  
  def self.find_by_year(y)
    first_year = Time.parse("01/01/#{y}").strftime('%Y-%m-%d %H:%M:%S')
    if (Date.parse("01/01/#{y}")+12.months) > Time.zone.now
      year = Time.zone.now
    else
      year = Date.parse("01/01/#{y}")+12.months
    end
    last_year = Time.parse(year.to_s).strftime('%Y-%m-%d %H:%M:%S')
    self.time_period(first_year,last_year)
  end
end
