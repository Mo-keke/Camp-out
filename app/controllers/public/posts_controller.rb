class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @user = current_user
    @post = Post.new
    @post.build_camp_layout
    @post.camp_layout.camp_gears.build
    @post.build_camp_meal
    @post.camp_meal.ingredients.build
    @post.build_campsite
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:success] = "投稿に成功しました。"
      redirect_to post_path(@post.id)
    else
      @user = current_user
      render 'new'
    end
  end

  def index
    @user = current_user
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @user = current_user
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @post_comments = PostComment.where(post_id: @post.id)
  end

  def timeline
    @user = current_user
    # 自分とフォロー中ユーザーの投稿を新着順に表示
    @posts = Post.where(user_id: [current_user.id, *current_user.following_ids]).order(created_at: :desc)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to mypage_path
  end

  private

  def post_params
    permitted_params = [:body]

    # テンプレートが選択されていた場合、そのフォームのデータのみを受け取る
    if params[:post][:camp_layouts_attributes].present?
      permitted_params << { camp_layouts_attributes: [:title, :description, camp_gears_attributes: [:name, :description] ] }
    end

    if params[:post][:camp_meals_attributes].present?
      permitted_params << { camp_meals_attributes: [:name, :description, :recipe, :time_required, ingredients_attributes: [:ingredient, :amount] ] }
    end

    if params[:post][:campsites_attributes].present?
      permitted_params << { campsites_attributes: [:name, :description, :address, :review] }
    end

    params.require(:post).permit(permitted_params)
  end
end
