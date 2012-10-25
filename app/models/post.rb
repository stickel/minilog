class Post < ActiveRecord::Base
  include ActionView::Helpers::TextHelper

  attr_accessible :body, :slug, :title

  validates_presence_of :body
  validates_uniqueness_of :url

  before_save :set_title

  acts_as_url :title, limit: 55

  def set_title
    self.title = truncate(self.body, length: 55, separator: ' ') if self.title.nil?
  end

  def to_param
    url
  end
end
