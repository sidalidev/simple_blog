class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update show]
  before_action :authenticate_user, only: %i[new create edit update]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params.merge(user_id: session[:user_id])

    if @post.valid?
      @post.save
      redirect_to root_path, notice: "Post created!"
    else
      redirect_to new_post_path,
                  status: :unprocessable_entity,
                  alert: @post.errors.full_messages.join(", ")
    end
  end

  def edit
  end

  def update
    redirect_to root_path unless @post.user_id == session[:user_id]

    if @post.update post_params
      redirect_to root_path, notice: "Post updated!"
    else
      redirect_to edit_post_path(@post),
                  status: :unprocessable_entity,
                  alert: @post.errors.full_messages.join(", ")
    end
  end

  def show
    @post = Post.find params[:id]
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def set_post
    @post = Post.find params[:id]
  end

  def authenticate_user
    redirect_to root_path unless session[:user_id]
  end
end
