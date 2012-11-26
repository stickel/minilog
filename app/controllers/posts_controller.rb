class PostsController < ApplicationController
  before_filter :authenticate_user!, except: [:home, :index, :show]

  def home
    @posts = Post.published.recent(10)
  end

  def index
    @posts = Post.published.recent(10)
  end

  def show
    @post = Post.find_by_url(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params[:post])
    respond_to do |wants|
      if @post.save
        wants.html { redirect_to edit_post_path(@post), notice: t('flash.actions.post.create.notice') }
        wants.json { render json: @post, notice: t('flash.actions.post.create.notice') }
      else
        wants.html { render :new, error: t('flash.actions.post.create.error') }
        wants.json { render json: @post, error: t('flash.actions.post.create.error') }
      end
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    respond_to do |wants|
      if @post.update_attributes(params[:post])
        wants.html { redirect_to edit_post_path(@post.id), notice: t('flash.actions.post.update.notice') }
        wants.json { render json: @post, notice: t('flash.actions.post.update.notice') }
      else
        wants.html { render :edit, error: t('flash.actions.post.update.error') }
        wants.json { render json: @post, error: t('flash.actions.post.update.error') }
      end
    end
  end

  def destroy
    if Post.find(params[:id]).delete_it!
      flash[:notice] = "Post marked as deleted"
    else
      flash[:alert] = "Post could not be deleted"
    end
    redirect_to :back
  end
end
