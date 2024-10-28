class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def top
    @users = User.page(params[:page]).per(5).order(created_at: :desc)
    @inquiries = Inquiry.page(params[:page]).per(5).order(created_at: :desc)
  end
end
