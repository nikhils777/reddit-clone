class Topics::PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
    @topic = Topic.find(params[:topic_id])
    authorize @topic
    @comment = Comment.new
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
  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    title = @post.title
    authorize @post
    if @post.destroy
      flash[:notice] = "\"#{title}\" was deleted successfully."
      redirect_to @topic
    else
      flash[:error] = "There was an error deleting the post."
      render :show
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :postpic)
  end
end
