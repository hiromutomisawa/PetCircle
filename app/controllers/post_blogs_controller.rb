class PostBlogsController < ApplicationController
  before_action :authenticate_user!

  def index
    if params[:tag_id]
      @tag_list = Tag.all
      @tag = Tag.find(params[:tag_id])
      @post_blogs = @tag.post_blogs.all
    else
      @tag_list = Tag.all
      @post_blogs = PostBlog.all
    end
  end

  def new
    @post_blog = PostBlog.new
  end

  def create
    @post_blog = PostBlog.new(post_blog_params)
    @post_blog.user_id = current_user.id
    # タグネームを","で区切りtagで保存する
    tag_list = params[:post_blog][:name].split(",")
    if @post_blog.save
      # save_blogsメソッドでタグを保存。メソッドはモデルで設定
      @post_blog.save_blogs(tag_list)
    end
    redirect_to post_blog_path(@post_blog)
  end

  def show
    @post_blog = PostBlog.find(params[:id])
    @user = @post_blog.user
    @post_comment = PostComment.new
  end

  def edit
    @post_blog = PostBlog.find(params[:id])
    @tag_list = @post_blog.tags.pluck(:name).join(",")
  end

  def destroy
    @post_blog = PostBlog.find(params[:id])
    @post_blog.destroy
    redirect_to post_blogs_path
  end

  def update
    @post_blog = PostBlog.find(params[:id])
    tag_list = params[:post_blog][:name].split(",")
    if @post_blog.update(post_blog_params)
      @post_blog.save_blogs(tag_list)
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
