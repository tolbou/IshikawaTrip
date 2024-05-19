# frozen_string_literal: true

class PostsController < ApplicationController
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
      # 解説/status: :unprocessable_entity
      render :now, status: :unprocessable_entity
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
      render :now, status: :unprocessable_entity
    end
  end

  def destroy
    post = current_user.posts.find(params[:id])
    post.destroy!
    # 　仮
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :address, :report)
  end
end
