class Public::InquiriesController < ApplicationController
  def new
    @inquiry = Inquiry.new
  end

  def create
    @inquiry = Inquiry.new(inquiry_params)
    @inquiry.user_id = current_user&.id

    if params[:inquiry][:email].present?
      @inquiry.email = params[:inquiry][:email]
    elsif current_user
      @inquiry.email = current_user.email
    else
      @inquiry.email = nil
    end

    if @inquiry.save
      redirect_to complete_inquiry_path
    else
      flash.now[:alert] = "投稿に失敗しました"
      render 'new'
    end
  end

  private

  def inquiry_params
    params.require(:inquiry).permit(:title, :email, :content)
  end
end
