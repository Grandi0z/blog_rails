class PostsController < ApplicationController
  before_action :set_user
  def index
    @current_user = current_user
    @posts = @user.posts.includes(comments: :author)
  end

  def show
    @post = Post.find(params[:id])
    @current_user = current_user
    @comments = @post.comments
    @comment = Comment.new(author: @current_user, post: @post)
  end

  def new
    if user_signed_in?
      @user = current_user
      @post = @user.posts.new
      respond_to do |format|
        format.html { render :new, locals: { post: @post } }
      end
      puts 'created'
    else
      redirect_to new_user_session_path, alert: 'You must be logged in to create a post.'
    end
  end

  def create
    @user = current_user
    @post = @user.posts.new(post_params)
    @post.author_id = @user.id
    respond_to do |format|
      format.html do
        if @post.save
          flash[:success] = ' Post created '
          redirect_to user_post_path(@user, @post)
        else
          render :new, status: :unprocessable_entity
        end
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    user = @post.author
    @post.destroy
    flash[:success] = ' Post deleted '
    redirect_to user_posts_path(user)
  end

  def post_params
    params.require(:post).permit(:title, :text, :author_id)
  end

  private

  def set_user
    @user = User.includes(posts: :comments).find(params[:user_id])
  end
end
