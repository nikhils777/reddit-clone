class CommentsController < ApplicationController
  def index
  end

  def new
    @topic = Topic.find( params[:topic_id] )
    @post = @topic.posts.find(params[:post_id])
    @comment = Comment.new
  end

  def show
    @topic = Topic.find( params[:topic_id] )
    @post = @topic.posts.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end
  def create
    @topic = Topic.find( params[:topic_id] )
    @post = @topic.posts.find(params[:post_id])
    @comment = current_user.comments.build(params.require(:comment).permit(:body))
    @comment.post = @post
    if @comment.save
      redirect_to [@topic, @post], notice: "Comment saved"
    else
      flash[:error] = "An error occured, please try again."
      render :new
    end
  end
  def destroy
    @topic = Topic.find( params[:topic_id] )
    @post = @topic.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    authorize @comment
    if @comment.destroy
      flash[:notice] = "Comment was removed."
      redirect_to [@topic, @post]
    else
      flash[:error] = "Comment coudnt be deleted. try again"
      redirect_to [@topic, @post]
    end
  end
end