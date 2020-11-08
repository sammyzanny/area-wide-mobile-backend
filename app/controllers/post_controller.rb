class PostsController < ApplicationController
    def index
        @posts = Post.all
        render json: @posts
    end

    def create
        @user = User.find(:user_id)
        @post = Post.new(post_params)
        if @post.save
            UserMailer.with(user: @user, post: @post).upload_email.deliver_later
            render json: {message: "Upload Success"}, status: :accepted
        else
            render json: {message: "Upload Failed"}, status: :rejected
        end
    end

    private

    def post_params
        params.permit(:message, :images, :user_id)
    end

end