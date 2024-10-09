class Public::UsersController < ApplicationController
  def mypage
    @user = current_user
    @posts = Post.where(user_id: current_user.id).order(created_at: :desc)
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      flash[:success] = "変更が正常に保存されました。"
      redirect_to mypage_path
    else
      render "edit"
    end
  end

  def show
    @myself = current_user
    @user = User.find(params[:id])
    @posts = Post.where(user_id: @user.id).order(created_at: :desc)
  end

  def unsubscribe
    @user = current_user
  end

  def destroy
    @user = current_user
    @user.destroy
    flash[:notice] = "アカウントの削除が完了しました。"
    redirect_to new_user_registration_path
  end

  private

  def user_params
    params.require(:user).permit(:profile_image, :name, :introduction)
  end
end