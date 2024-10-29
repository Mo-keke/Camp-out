class Public::BookMarksController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @bookmarked_posts = Post.joins(:book_marks).where(book_marks: { user_id: current_user.id }).includes(:book_marks).page(params[:page]).per(20).order(created_at: :desc)
  end

  def create
    @post = Post.find(params[:post_id])
    book_mark = current_user.book_marks.new(post_id: @post.id)
    book_mark.save
  end

  def destroy
    @post = Post.find(params[:post_id])
    book_mark = current_user.book_marks.find_by(post_id: @post.id)
    book_mark.destroy
  end
end
