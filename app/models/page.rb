class Page < ActiveRecord::Base
  # has_many :uploads
  validates_presence_of :permalink, :title, :body_raw
  has_permalink :permalink, :unique => true
  # accepts_nested_attributes_for :uploads, :allow_destroy => true, :reject_if => lambda { |i| i['upload'].blank? }
  
  named_scope :published, { :conditions => ['is_active = ?', true] }
  named_scope :sorted, lambda { |*order| {:order => ['page_order ', (order.first || 'ASC')]} }
  named_scope :parents, { :conditions => 'parent_id IS NULL' }
  named_scope :children, lambda { |parent| { :conditions => ['parent_id = ?', parent] } }
  
  def self.has_children?(page_id)
    if Page.children(page_id).size >= 1
      return Page.published.children(page_id)
    end
  end
  
end
