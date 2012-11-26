require 'spec_helper'

describe PostsController do
  render_views

  describe 'GET #home' do
    context 'with no posts' do
      before(:each) do
        get :home
      end

      it 'renders the home template' do
        response.should render_template :home
      end

      it 'returns empty array' do
        assigns(:posts).should be_empty
      end

      it 'shows "sorry" message' do
        response.body.should have_content I18n.t('posts.home.no_posts')
      end
    end

    context 'with posts' do
      before(:each) do
        @posts = create_list :post, 12, :published
        get :home
      end

      it 'renders the :home template' do
        response.should render_template 'home'
      end

      it 'shows the most recent posts' do
        @posts.sort! { |a, b| a.published_at <=> b.published_at }
        assigns(:posts).all.should =~ @posts[(@posts.length - 10)..@posts.length].reverse
      end

      it 'shows the correct number of posts' do
        assigns(:posts).count.should eq(10)
      end
    end

    context 'when logged in' do
      before(:each) do
        user = FactoryGirl.create(:user)
        sign_in user
        get :home
      end

      it 'has a current_user' do
        subject.current_user.should_not be_nil
      end

      it 'shows "new post" link' do
        response.body.should have_link 'New post'
      end
    end
  end

  describe 'GET #index' do
    context 'with posts' do
      before(:each) do
        @posts = create_list :post, 12, :published
        get :index
      end

      it 'shows the N most recent posts' do
        @posts.sort! {|a, b| a.published_at <=> b.published_at }
        assigns(:posts).all.should =~ @posts[(@posts.length - 10)..@posts.length].reverse
      end

      it 'renders the :index template' do
        response.should render_template :index
      end
    end

    context 'when logged in' do
      before(:each) do
        user = FactoryGirl.create(:user)
        sign_in user
        get :index
      end

      it 'has a current_user' do
        subject.current_user.should_not be_nil
      end

      it 'shows "new post" link' do
        response.body.should have_link 'New post'
      end
    end
  end

  describe 'GET #new' do
    context 'when not logged in' do
      it 'redirects to Posts#index' do
        get :new
        response.should redirect_to new_user_session_path()
      end
    end

    context 'when signed in' do
      before(:each) do
        user = FactoryGirl.create(:user)
        sign_in user
        get :new
      end

      it 'creates a new post object' do
        assigns(:post).should be_new_record
      end

      it 'renders :new template' do
        response.should render_template :new
      end

      it 'renders post/form partial' do
        response.should render_template '_form'
      end
    end
  end

  describe 'POST #create' do
    before(:each) do
      user = FactoryGirl.create(:user)
      sign_in user
    end

    context 'with valid attributes' do
      it 'saves the post to the database' do
        expect {
          post :create, post: FactoryGirl.attributes_for(:post)
        }.to change(Post, :count).by(1)
      end

      it 'redirects to the :edit template' do
        post :create, post: FactoryGirl.attributes_for(:post)
        response.should redirect_to edit_post_path(Post.last)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the post to the database' do
        expect {
          post :create, post: FactoryGirl.attributes_for(:invalid_post)
        }.to_not change(Post, :count)
      end

      it 're-renders the :new template' do
        post :create, post: FactoryGirl.attributes_for(:invalid_post)
        response.should render_template :new
      end
    end
  end

  describe 'GET #show' do
    before(:each) do
      @post = FactoryGirl.create(:published_post)
      get :show, id: @post
    end

    it 'assigns the requested post to @post' do
      assigns(:post).should eq(@post)
    end

    it 'renders the :show template' do
      response.should render_template :show
    end
  end

  describe 'GET #edit' do
    before(:each) do
      sign_in FactoryGirl.create(:user)
      @post = FactoryGirl.create(:post)
      get :edit, id: @post.id
    end

    it 'renders :edit template' do
      response.should render_template :edit
      response.should render_template '_form'
    end

    it 'returns correct object' do
      assigns(:post).should eq(@post)
    end
  end

  describe 'PUT #update' do
    before(:each) do
      sign_in FactoryGirl.create(:user)
      @post = FactoryGirl.create(:post, title: 'Update this post')
    end

    context 'valid attributes' do
      it 'finds the requested post' do
        put :update, id: @post.id, post: FactoryGirl.attributes_for(:post)
        assigns(:post).should eq(@post)
      end

      it 'changes attributes for @post' do
        put :update, id: @post.id, post: FactoryGirl.attributes_for(:post, title: 'A new title')
        @post.reload
        @post.title.should eq('A new title')
      end

      it 'redirects to the :edit template' do
        put :update, id: @post.id, post: FactoryGirl.attributes_for(:post)
        response.should redirect_to edit_post_path(@post.id)
      end
    end

    context 'invalid attributes' do
      it 'does not update the @post' do
        put :update, id: @post.id, post: FactoryGirl.attributes_for(:post, title: 'A new title', body: '')
        @post.reload
        @post.title.should eq('Update this post')
      end

      it 're-renders the :edit template' do
        put :update, id: @post.id, post: FactoryGirl.attributes_for(:invalid_post)
        response.should render_template :edit
      end
    end
  end
end
