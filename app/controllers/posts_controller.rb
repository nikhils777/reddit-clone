class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @topic = Topic.find(params[:topic_id])
    @comments = @post.comments
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    authorize @post
  end
  def create
    @topic = Topic.find(params[:topic_id])
    @post = current_user.posts.build(post_params)
    @post.topic = @topic
    authorize @post
    if @post.save
      redirect_to [@topic, @post], notice: "Post was saved successfully."
    else
      flash[:error] = "Your post was not saved properly, please try again."
      render :new
    end
  end
  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
  end
  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
    if @post.update_attributes(post_params)
      flash[:notice] = "Post Updated!"
      redirect_to [@topic, @post]
    else
      flash[:error] = "The post was not updated successfully, please try again."
      render :edit
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :postpic)
  end
end
