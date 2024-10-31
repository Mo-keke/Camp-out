class Public::CampMealsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @camp_meals = CampMeal.includes(
                    :ingredients,
                    post: :user,
                    camp_meal_images_attachments: :blob
                  )
                  .order(created_at: :desc)
                  .limit(10)
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
      @camp_meal.ingredients.build
      @campsite = Campsite.new
      @layout_form_initial_value = "キャンプレイアウトテンプレートを用いて投稿を作成しました！"
      @meal_form_initial_value = "キャンプ飯テンプレートを用いて投稿を作成しました！"
      @site_form_initial_value = "キャンプ場テンプレートを用いて投稿を作成しました！"
      flash.now[:alert] = "投稿に失敗しました。"
      render 'public/posts/new'
    end
  end

  private

  def camp_meal_params
    params.require(:camp_meal).permit(:name, :description, :recipe, :time_required, :body, :user_id, camp_meal_images: [], ingredients_attributes: [:id, :name, :amount, :_destroy])
  end
end
