class Public::PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.save(post_id: post.id)
    redirect_back fallback_location: root_path
  end

  def destroy
    post_comment = PostComment.find(params[:id])
    post_comment.destroy
    redirect_back fallback_location: root_path
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
