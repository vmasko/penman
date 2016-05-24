class PostsController < ApplicationController

  def index
    @posts = Post.paginate(page: params[:page], per_page: 20)
  end

  def show
    @post = find_post
  end

  def new
    @post = Post.new
  end

  def create
    @post = find_post
    if @post.save
      flash[:success] = "Post is saved!"
      redirect_to @post
    else
      render 'new'
    end
  end

  def edit
    @post = find_post
  end

  def update
    @post = find_post
    if @post.update_attributes(post_params)
      flash[:sucess] = "Post successfully updated!"
    else
      render 'edit'
    end
  end

  def destroy
    find_post.destroy
  end
end

  private

  def post_params
    params.require(:post).permit(:title, :content, :status, :image)
  end

  def find_post
    Post.find(params[:id])
  end
