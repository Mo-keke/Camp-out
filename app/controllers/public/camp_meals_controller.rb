class Public::CampMealsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @camp_meals = CampMeal.order(created_at: :desc).limit(10)
  end

  def create
    @camp_meal = CampMeal.new(camp_meal_params)
    if @camp_meal.save
      flash[:success] = "投稿に成功しました。"
      redirect_to @camp_meal.post
    else
      @user = current_user
      @post = Post.new
      @camp_layout = CampLayout.new
      @camp_layout.camp_gears.build
      @campsite = Campsite.new
      flash.now[:alert] = "投稿に失敗しました"
      render 'public/posts/new'
    end
  end

  private

  def camp_meal_params
    params.require(:camp_meal).permit(:name, :description, :recipe, :time_required, :body, :user_id, camp_meal_images: [], ingredients_attributes: [:id, :ingredient, :amount, :_destroy])
  end
end
