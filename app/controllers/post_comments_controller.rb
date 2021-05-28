class PostCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    post_blog = PostBlog.find(params[:post_blog_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_blog_id = post_blog.id
    comment.save
    redirect_to post_blog_path(post_blog)
  end

  def destroy
    PostComment.find_by(id: params[:id], post_blog_id: params[:post_blog_id]).destroy
    redirect_to post_blog_path(params[:post_blog_id])
  end

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
