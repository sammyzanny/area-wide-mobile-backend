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
        user = current_user
        post = Post.new(message: params[:post][:message], address: params[:post][:address], billing: params[:post][:billing], contact: params[:post][:contact])
        images = params[:post][:images]

       post.images.attach(images)

        post.user_id = user.id
        if post.save
            begin
                UserMailer.with(user: user, post: post).upload_email.deliver_now
                render json: {message: "Upload Success"}, status: :accepted
            rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
                render json: {message: "Server Error"}, status: :rejected
            end
        else
            render json: {message: "Upload Failed"}, status: :rejected
        end
    end
    
    # def create
    #     user = current_user
    #     post = Post.new(message: params[:post][:message], address: params[:post][:address], billing: params[:post][:billing], contact: params[:post][:contact])
    #     images = params[:post][:images]
    #     images_array = []
    #     images.each{|img| 
    #         decoded_data = Base64.decode64(img)

    #         images_array.push({ 
    #             io: StringIO.new(decoded_data),
    #             filename: 'image.jpg'
    #         })
    #     }

    #    post.images.attach(images_array)

    #     post.user_id = user.id
    #     if post.save
    #         UserMailer.with(user: user, post: post).upload_email.deliver_now
    #         render json: {message: "Upload Success"}, status: :accepted
    #     else
    #         render json: {message: "Upload Failed"}, status: :rejected
    #     end
    # end

    private

    def post_params
        params.require(:post).permit(:message, :address, :billing, :contact, images: [])
    end

end