class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @user = current_user
    @post = Post.new
    @camp_layout = CampLayout.new
    @camp_layout.camp_gears.build
    @camp_meal = CampMeal.new
    @camp_meal.ingredients.build
    @campsite = Campsite.new
    @layout_form_initial_value = "キャンプレイアウトテンプレートを用いて投稿を作成しました！"
    @meal_form_initial_value = "キャンプ飯テンプレートを用いて投稿を作成しました！"
    @site_form_initial_value = "キャンプ場テンプレートを用いて投稿を作成しました！"
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      flash[:success] = "投稿に成功しました。"
      redirect_to post_path(@post.id)
    else
      @user = current_user
      @camp_layout = CampLayout.new
      @camp_layout.camp_gears.build
      @camp_meal = CampMeal.new
      @camp_meal.ingredients.build
      @campsite = Campsite.new
      @layout_form_initial_value = "キャンプレイアウトテンプレートを用いて投稿を作成しました！"
      @meal_form_initial_value = "キャンプ飯テンプレートを用いて投稿を作成しました！"
      @site_form_initial_value = "キャンプ場テンプレートを用いて投稿を作成しました！"
      flash.now[:alert] = "投稿に失敗しました。"
      render 'new'
    end
  end

  def index
    @user = current_user
    @posts = Post.page(params[:page]).per(20).order(created_at: :desc)
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
    @posts = Post.where(user_id: [current_user.id, *current_user.following_ids]).page(params[:page]).per(20).order(created_at: :desc)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to mypage_path
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end