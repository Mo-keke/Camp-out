class Public::BookMarksController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
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
