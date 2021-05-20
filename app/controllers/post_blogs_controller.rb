class PostBlogsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @post_blogs = PostBlog.all
  end

  def new
    @post_blog = PostBlog.new
  end

  def create
    @post_blog = PostBlog.new(post_blog_params)
    @post_blog.user_id = current_user.id
    @post_blog.save
    redirect_to post_blogs_path
  end

  def show
    @post_blog = PostBlog.find(params[:id])
    @user = @post_blog.user
    @post_comment = PostComment.new
  end

  def edit
    @post_blog = PostBlog.find(params[:id])
  end

  def destroy
    @post_blog = PostBlog.find(params[:id])
    @post_blog.destroy
    redirect_to post_blogs_path
  end

  def update
    @post_blog = PostBlog.find(params[:id])
    if @post_blog.update(post_blog_params)
      flash[:success] = "更新が完了しました。"
      redirect_to post_blog_path(@post_blog.id)
    else
      render action: :edit
    end
  end

  private

  def post_blog_params
    params.require(:post_blog).permit(:image, :title, :body)
  end

end
