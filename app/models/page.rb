class Page < ActiveRecord::Base
  validates_presence_of :permalink, :title, :body_raw
  has_permalink :permalink
  
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
