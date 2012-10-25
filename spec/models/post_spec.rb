require 'spec_helper'
include ActionView::Helpers::TextHelper

describe Post do
  it 'is invalid without a body' do
    FactoryGirl.build(:post, body: nil).should_not be_valid
  end

  it 'has a unique slug' do
    post = FactoryGirl.create(:post)
    post_2 = FactoryGirl.create(:post)
    post.url.should_not eq(post_2.url)
  end

  it 'makes a slug from the title' do
    post = FactoryGirl.create(:post)
    post.url.should eq(post.title.to_url)
  end

  it 'sets the title to the first line of body when title is empty' do
    post = FactoryGirl.create(:post, title: nil)
    post.title.should eq(truncate(post.body, length: 55, separator: ' '))
  end

  context 'logged out user' do
  end

  context 'logged in user' do
  end
end
