class Post < ActiveRecord::Base
  include ActionView::Helpers::TextHelper

  attr_accessible :body, :url, :title, :published_at, :deleted_at, :state, :visibility

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

  state_machine :state, initial: :draft do
    state :draft, value: 0
    state :published, value: 1
    state :deleted, value: 2

    after_transition :draft => any - :draft do |post, transition|
      # TimeZone needs to be set before running this test.
      post.update_attribute("#{transition.to_name}_at", DateTime.now)
    end

    event :draftize do
      transition published: :draft
    end

    event :publish do
      transition draft: :published
    end

    event :delete_it do
      transition [:published, :draft] => :deleted
    end
  end

  state_machine :visibility, initial: :public do
    state :private, value: 0
    state :public, value: 1

    event :publicize do
      transition private: :public
    end

    event :privatize do
      transition public: :private
    end
  end
end
