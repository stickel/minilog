class PostTag < ActiveRecord::Base
  belongs_to :posts
  belongs_to :tags
end
