class PostsController < ApplicationController
    def index
        @admin = User.find(1)
        @posts = Post.all
        if @admin == current_user
            render json: @posts
        else
            render json: {error: "Unauthorized Access"}
        end
            
    end

    def create
        @user = current_user
        @post = Post.new(post_params)
        @post.user_id = @user.id
        if @post.save
            UserMailer.with(user: @user, post: @post).upload_email.deliver_now
            render json: {message: "Upload Success"}, status: :accepted
        else
            render json: {message: "Upload Failed"}, status: :rejected
        end
    end

    private

    def post_params
        params.require(:post).permit(:message, :address, :billing, :contact, images: [])
    end

end