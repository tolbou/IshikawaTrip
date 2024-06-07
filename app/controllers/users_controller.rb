class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update]

  def show
    @posts = @user.posts
    @liked_posts = @user.liked_posts
  end

  def update
    @posts = @user.posts
    @liked_posts = @user.liked_posts
    if @user.update(user_params)
      redirect_to mypage_path, notice: 'プロフィールを更新しました。'
    else
      render :show
    end
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :image)
  end
end
