class Comment < ActiveRecord::Base
  belongs_to :post
  
  # Scopes
  named_scope :unapproved, :conditions => ['is_approved = ?',false]
  
end
