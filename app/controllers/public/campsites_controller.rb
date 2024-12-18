class Public::CampsitesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @campsites = Campsite.includes(
                  post: :user,
                  campsite_images_attachments: :blob
                )
                .order(created_at: :desc)
                .limit(10)
  end

  def create
    @campsite = Campsite.new(campsite_params)
    if @campsite.save
      flash[:success] = "投稿に成功しました。"
      redirect_to @campsite.post
    else
      @user = current_user
      @post = Post.new
      @camp_layout = CampLayout.new
      @camp_layout.camp_gears.build
      @camp_meal = CampMeal.new
      @camp_meal.ingredients.build
      @layout_form_initial_value = "キャンプレイアウトテンプレートを用いて投稿を作成しました！"
      @meal_form_initial_value = "キャンプ飯テンプレートを用いて投稿を作成しました！"
      @site_form_initial_value = "キャンプ場テンプレートを用いて投稿を作成しました！"
      flash.now[:alert] = "投稿に失敗しました。"
      render 'public/posts/new'
    end
  end

  private

  def campsite_params
    params.require(:campsite).permit(:name, :description, :address, :review, :body, :user_id, campsite_images: [])
  end
end
