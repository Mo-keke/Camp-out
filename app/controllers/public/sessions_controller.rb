# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def create
    user = User.find_by(email: params[:user][:email])

    # ユーザーが存在し、かつアクティブでない場合の処理
    if user && !user.is_active
      flash[:alert] = "アカウント名：#{user.name} は現在アカウントの利用が制限されています。"
      redirect_to new_user_session_path
    else
      super # 通常のDeviseのログイン処理を実行
    end
  end

  def after_sign_in_path_for(resource)
    session[:previous_url] || mypage_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
