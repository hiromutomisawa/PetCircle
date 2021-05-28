class PostBlogsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:tag_id]
      @tag_lists = Tag.all
      @tag = Tag.find(params[:tag_id])
      @post_blogs = @tag.post_blogs.all
    else
      @tag_lists = Tag.all
      @post_blogs = PostBlog.all
    end
  end

  def new
    @post_blog = PostBlog.new
    @tag_lists = Tag.all
  end

  def create
    @post_blog = PostBlog.new(post_blog_params)
    @post_blog.user_id = current_user.id
    # タグネームを","で区切りtagで保存する
    tag_list = params[:post_blog][:name].split(",")
    if @post_blog.save
      # save_blogsメソッドでタグを保存。メソッドはモデルで設定
      @post_blog.save_blogs(tag_list)
      redirect_to post_blog_path(@post_blog)
    else
      @tag_lists = Tag.all
      render :new
    end
  end

  def show
    @post_blog = PostBlog.find(params[:id])
    @user = @post_blog.user
    @post_comment = PostComment.new
  end

  def edit
    @post_blog = PostBlog.find(params[:id])
    @tag_list = @post_blog.tags.pluck(:name).join(",")
    @tag_lists = Tag.all
  end

  def destroy
    @post_blog = PostBlog.find(params[:id])
    @post_blog.destroy
    redirect_to user_path(@post_blog.user_id)
  end

  def update
    @post_blog = PostBlog.find(params[:id])
    tag_list = params[:post_blog][:name].split(",")
    if @post_blog.update(post_blog_params)
      @post_blog.save_blogs(tag_list)
      redirect_to post_blog_path(@post_blog.id)
    else
      @tag_lists = Tag.all
      render :edit
    end
  end

  private

  def post_blog_params
    params.require(:post_blog).permit(:image, :title, :body)
  end

end
