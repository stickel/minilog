require 'spec_helper'
include ActionView::Helpers::TextHelper

describe Post do
  it 'is invalid without a body' do
    FactoryGirl.build(:post, body: nil).should_not be_valid
  end

  it 'sets the title to the first line of body when title is empty' do
    post = FactoryGirl.create(:post, title: nil)
    post.title.should eq(truncate(post.body, length: 55, separator: ' '))
  end

  it 'makes a slug from the title' do
    post = FactoryGirl.create(:post)
    post.url.should eq(post.title.to_url)
  end

  it 'has a unique slug' do
    post = FactoryGirl.create(:post)
    post_2 = FactoryGirl.create(:post)
    post.url.should_not eq(post_2.url)
  end

  context 'state' do
    before(:each) do
      @post = FactoryGirl.create(:post)
    end

    it 'is draft by default' do
      @post.draft?.should be_true
    end

    it 'can be published' do
      @post.publish!
      @post.published?.should be_true
      @post.published_at.should eq(DateTime.now)
    end

    it 'can become draft after being published' do
      @post.publish!
      @post.published?.should be_true
      @post.draftize!
      @post.draft?.should be_true
    end

    it 'can be deleted' do
      @post.delete_it!
      @post.deleted?.should be_true
    end
  end

  context 'visibility' do
    before(:each) do
      @post = FactoryGirl.create(:post)
    end

    it 'is public by default' do
      @post.public?.should be_true
    end

    it 'can be private' do
      @post.privatize!
      @post.private?.should be_true
    end
  end
end
