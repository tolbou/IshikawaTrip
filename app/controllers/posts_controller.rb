class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like]
  before_action :set_tags, only: [:new, :create, :edit, :update]
  before_action :check_logged_in, except: [:index, :show]

  def index
    @posts = Post.all

    if params[:q].present?
      @posts = @posts.where("posts.title LIKE ? OR posts.report LIKE ? OR posts.address LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%")
    end

    if params[:tag_id].present?
      @posts = @posts.joins(:tags).where(tags: { id: params[:tag_id] })
    end

    if params[:month_tag_id].present?
      @posts = @posts.joins(:month_tags).where(month_tags: { id: params[:month_tag_id] })
    end

    respond_to do |format|
      format.html
      format.json { render json: @posts.to_json(include: { tags: { only: :title }, month_tags: { only: :title } }, methods: :image_url) }
    end
  end

  def show
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
      redirect_to post_path(@post)
    else
      flash.now[:danger] = '更新に失敗しました。'
      render :edit, status: :unprocessable_entity
    end
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
    if @post.destroy
      flash[:success] = '投稿を削除しました。'
      if request.referer.include?(mypage_path)
        redirect_to mypage_path(anchor: 'my-posts')
      else
        redirect_to posts_path
      end
    else
      flash.now[:danger] = '投稿の削除に失敗しました。'
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :report, :address, :image, tag_ids: [], month_tag_ids: [])
  end

  def set_tags
    @tags = Tag.all
    @month_tags = MonthTag.all
  end
end
