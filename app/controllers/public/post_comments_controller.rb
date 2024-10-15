class Public::PostCommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    @post_comments = PostComment.where(post_id: post.id)
    post_comment = current_user.post_comments.build(post_comment_params.merge(post_id: post.id))
    post_comment.save
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
