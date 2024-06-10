class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update]
  before_action :check_logged_in, except: [:show]

  def show
    if @user.nil?
      redirect_to before_login_path
    else
      @posts = @user.posts
      @liked_posts = @user.liked_posts
    end
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

  def my_posts
    @user = current_user
    @posts = @user.posts
  end

  def liked_posts
    @user = current_user
    @liked_posts = @user.liked_posts
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:name, :image)
  end
end
