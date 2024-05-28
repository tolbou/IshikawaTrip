class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like]
  before_action :set_tags, only: [:new, :create, :edit, :update]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = '投稿完了しました。'
      redirect_to posts_path
    else
      flash.now[:danger] = '投稿に失敗しました。'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:success] = '更新完了しました。'
      redirect_to @post
    else
      flash.now[:danger] = '更新に失敗しました。'
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end

  def like
    like = @post.likes.find_by(user: current_user)
    if like
      like.destroy
      @liked = false
    else
      @post.likes.create(user: current_user)
      @liked = true
    end

    respond_to do |format|
      format.html { redirect_to @post }
      format.js
    end
  end

  def destroy
    @post.destroy!
    flash[:success] = '投稿を削除しました。'
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :address, :report, :image, :image_cache, tag_ids: [], month_tag_ids: [])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_tags
    @tags = Tag.all
    @month_tags = MonthTag.all
  end
end
