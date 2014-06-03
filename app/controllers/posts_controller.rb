class PostsController < ApplicationController
  def index
    @posts = Post.all
    authorize @posts
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    authorize @post
  end
  def create
    @post = current_user.posts.build(params.require(:post).permit(:title, :body))
    authorize @post
    if @post.save
      flash[:notice] = "You just posted successfully!"
      redirect_to @post
    else
      flash[:error] = "Your post was not saved properly, please try again."
      render :new
    end
  end
  def edit
    @post = Post.find(params[:id])
    authorize @post
  end
  def update
    @post = Post.find(params[:id])
    authorize @post
    if @post.update_attributes(params.require(:post).permit(:title, :body))
      flash[:notice] = "Post Updated!"
      redirect_to @post
    else
      flash[:error] = "The post was not updated successfully, please try again."
      render :edit
    end
  end
end
