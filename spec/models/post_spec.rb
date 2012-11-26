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
      Timecop.freeze
      @post.publish!
      @post.published?.should be_true
      @post.published_at.should eq(Time.zone.now)
    end

    it 'can become draft after being published' do
      @post.publish!
      @post.published?.should be_true
      @post.draftize!
      @post.draft?.should be_true
    end

    it 'can be deleted' do
      Timecop.freeze
      @post.delete_it!
      @post.deleted?.should be_true
      @post.deleted_at.should eq(Time.zone.now)
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

  context '#published' do
    it 'returns only published posts' do
      create_list :post, 3, :published
      draft = create :post, title: 'this is a draft'
      Post.published.should_not include(draft)
      Post.published.count.should eq(3)
    end

    it 'is empty when it has no posts' do
      Post.published.count.should eq(0)
      Post.published.should be_empty
    end
  end

  context '#recent' do
    context 'with posts' do
      before(:each) do
        @posts = create_list :post, 4, :published
      end

      it 'returns latest N number of posts' do
        posts = Post.recent(4)
        posts.count.should eq(4)
        posts.count.should_not eq(3)
      end

      it 'returns newest posts first' do
        @posts.sort! { |a, b| a.published_at <=> b.published_at }
        Post.recent(4).all.should eq(@posts.reverse)
      end
    end

    context 'without posts' do
      it 'returns empty when no posts' do
        Post.recent(2).count.should eq(0)
        Post.recent(2).should be_empty
      end
    end
  end

end
