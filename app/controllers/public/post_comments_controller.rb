class Public::PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    post = Post.find(params[:post_id])
    @post_comments = PostComment.where(post_id: post.id)
    @post_comment = current_user.post_comments.build(post_comment_params.merge(post_id: post.id))
    unless @post_comment.save
      flash.now[:alert] = "コメントの送信に失敗しました。"
      render 'error'
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    @post_comments = PostComment.where(post_id: post.id)
    post_comment = PostComment.find(params[:id])
    post_comment.destroy
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
