class Page < ActiveRecord::Base
  validates_presence_of :permalink, :title, :body_raw
  has_permalink :permalink
  
  
end
