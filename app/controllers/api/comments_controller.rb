module Api
  class CommentsController < ApplicationController
    before_action :set_post
    skip_before_action :verify_authenticity_token, only: [:create], if: -> { request.format.json? }

    before_action :authenticate_user!, only: [:create]

    def index
      @comments = @post.comments
      render json: @comments
    end

    def create
      @comment = @post.comments.build(comment_params)
      @comment.author = current_user

      if @comment.save
        render json: @comment, status: :created, message: 'Comment added'
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end

    private

    def set_post
      @post = Post.find(params[:post_id])
    end

    def load_comments
      user = User.find(params[:user_id])
      post = user.posts.find(params[:post_id])
      post.comments
    end

    def comment_params
      params.permit(:text)
    end

    def current_user
      user_id = decoded_auth_token['user_id']
      User.find_by(id: user_id)
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      nil
    end

    def authenticate_user!
      render json: { error: 'unauthorized' }, status: :unauthorized unless current_user
    end

    def decoded_auth_token
      token = request.headers['Authorization'].to_s.split.last
      JWT.decode(token, Rails.application.secret_key_base)[0]
    end
  end
end
