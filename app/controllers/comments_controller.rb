class CommentsController < ApplicationController
  respond_to :html, :js
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
    @comments = @post.comments
    @comment = current_user.comments.build( comment_params )
    @comment.post = @post
    @new_comment = Comment.new
    if @comment.save
      flash[:notice] = "Comment created!"
    else
      flash[:error] = "An error occured, please try again."
    end
    respond_with(@comment) do |f|
      f.html { redirect_to [@topic, @post]}
    end
  end
  def destroy
    @topic = Topic.find( params[:topic_id] )
    @post = @topic.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    authorize @comment
    if @comment.destroy
      flash[:notice] = "Comment was removed."
    else
      flash[:error] = "Comment coudnt be deleted. try again"
    end
    respond_with(@comment) do |f|
      f.html { redirect_to [@topic, @post]}
    end
  end

  private

  def comment_params
    params.require(:comment).permit(
      :body,
      :post_id
      )
  end
end
