class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    @tags = Tag.all
    @month_tags = MonthTag.all
    # view側で直接APIキーを参照することができない為、一度Controllerを挟む
    @google_maps_api_key = ENV['GOOGLE_MAPS_API_KEY']
    Rails.logger.debug "Tags: #{@tags.inspect}"
    Rails.logger.debug "MonthTags: #{@month_tags.inspect}"
  end

  def create
    @post = current_user.posts.build(post_params)
    Rails.logger.debug "パラメータ内容: #{post_params.inspect}"
    if @post.save
      flash[:success] = '投稿完了しました。'
      redirect_to posts_path
    else
      flash.now[:danger] = '投稿に失敗しました。'
      # 解説/status: :unprocessable_entity
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update
      flash[:success] = '更新完了しました。'
      # 　仮
      redirect_to posts_path
    else
      flash.now[:danger] = '更新に失敗しました。'
      # 解説/status: :unprocessable_entity
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
    # 　仮
    redirect_to posts_path
  end

  private

  # ストロングパラメータ
  def post_params
    params.require(:post).permit(:title, :address, :report, :image, :image_cache, tag_ids: [], month_tag_ids: [])
  end
end
