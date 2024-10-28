class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id).page(params[:page]).per(10).order(created_at: :desc)
    @comments = PostComment.where(user_id: @user.id).page(params[:page]).per(5).order(created_at: :desc)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "会員ステータスが変更されました。"
      redirect_to admin_user_path(@user.id)
    else
      @posts = Post.where(user_id: @user.id).page(params[:page]).per(10)
      @comments = PostComment.where(user_id: @user.id).page(params[:page]).per(5)
      flash.now[:alert] = "会員ステータスの変更に失敗ました。"
      render 'show'
    end
  end

  private

  def user_params
    params.require(:user).permit(:is_active)
  end
end
