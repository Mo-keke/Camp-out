class Public::CampLayoutsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
  end

  def create
    @camp_layout = CampLayout.new(camp_layout_params)
    if @camp_layout.save
      flash[:success] = "投稿に成功しました。"
      redirect_to @camp_layout.post
    else
      @user = current_user
      @post = Post.new
      @camp_meal = CampMeal.new
      @camp_meal.ingredients.build
      @campsite = Campsite.new
      flash.now[:alert] = "投稿に失敗しました。"
      render 'public/posts/new'
    end
  end

  private

  def camp_layout_params
    params.require(:camp_layout).permit(:title, :description, :body, :user_id, camp_layout_images: [], camp_gears_attributes: [:id, :camp_gear_image, :name, :description, :_destroy])
  end
end