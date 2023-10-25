class CommentsController < ApplicationController
  before_action :attr_user_and_post

  before_action :find_comment, only: [:destroy]

  def new
    @comment = Comment.new(user: current_user, post: @post)
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author_id = params[:user_id]
    @comment.post_id = params[:post_id]
    if @comment.save
      flash[:success] = ' Comment succefully '
      redirect_to user_post_path(@user, @post)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @comment_to_del.destroy
    flash[:success] = ' comment deleted '
    redirect_to user_post_path(@post.author, @post)
  end

  private

  def attr_user_and_post
    # we be use in the user_post_path
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:author_id, :post_id, :text)
  end

  def find_comment
    @comment_to_del = @post.comments.find(params[:id])
  end
end
