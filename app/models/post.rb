class Post < ActiveRecord::Base
  has_many :uploads
  has_and_belongs_to_many :tags
  belongs_to :person
  validates_presence_of :permalink, :title, :body_raw
  has_permalink :permalink, :unique => true
  accepts_nested_attributes_for :uploads, :allow_destroy => true, :reject_if => lambda { |i| i['upload'].blank? }
  
  named_scope :published, lambda { {:conditions => ['is_active = ? AND published_at <= ?', true, Time.zone.now]} }
  named_scope :author, lambda { |a| {:conditions => ['is_active = ? AND author_id = ? AND published_at <= ?',true,a,Time.zone.now], :order => 'published_at DESC'} }
  named_scope :time_period, lambda { |dstart,dend| {:conditions => ['published_at BETWEEN ? AND ?',dstart,dend]} }
  named_scope :recent, lambda { |*n| {:order => 'published_at DESC', :limit => (n.first || 5)} }
  named_scope :years, { :group => 'year(published_at)' }
  named_scope :months, { :group => 'month(published_at), year(published_at)' }
  named_scope :newest_first, { :order => 'published_at DESC' }
  named_scope :limited_set, lambda { |*o| {:offset => (o.first || Preference.get_pref('items_on_index')), :limit => Preference.get_pref('items_on_index')}}
  named_scope :with_tag, lambda { |tag, *limit| {:select => 'posts.*', :include => :tags, :conditions => ['tags.name = ?', tag], :limit => (limit.first || 5)} }
  
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