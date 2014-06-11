class PostsController < ApplicationController
  def index
    @posts = Post.where("posts.created_at > ?",7.days.ago).paginate(page: params[:page], per_page: 10)
  end
end
