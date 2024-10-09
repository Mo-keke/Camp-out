class Public::PostsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      flash[:success] = "投稿に成功しました。"
      redirect_to post_path
    else
      render 'new'
    end
  end

  def index
    # 自分とフォロー中ユーザーの投稿を新着順に表示
    @posts = Post.where(user_id: [current_user.id, *current_user.following_ids]).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to mypage_path
  end

  private

  def post_params
    params.require(:post).permit(:post_images, :body)
  end
end
