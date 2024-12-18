class Admin::InquiriesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @inquiries = Inquiry.page(params[:page]).per(10).order(created_at: :desc)
  end

  def show
    @inquiry = Inquiry.find(params[:id])
  end
end
