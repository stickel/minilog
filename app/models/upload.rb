class Upload < ActiveRecord::Base
  belongs_to :post
  
  has_attached_file :upload, 
                    :styles => {:thumb => "50x50#", :small => "100x100>", :large => "300x300>"},
                    :url => "/images/uploads/:id_:basename_:style.:extension",
                    :path => ":rails_root/public/images/uploads/:id_:basename_:style.:extension"
  
  # This validation takes into account all uploads together not each upload
  # validates_attachment_size :upload, :less_than => 3.megabytes
  validates_attachment_content_type :upload, :content_type => ["image/jpeg", "image/jpg", "image/png", "image/gif", "image/pjpeg", "image/x-png"]
end
