class UserMailer < ApplicationMailer
    default from: "postmaster@sandbox030884ec0bfb437989dab7eae1d29204.mailgun.org"

    def upload_email
        @user = params[:user]
        @post = params[:post]
        @post.images.each_with_index do |file, q|
            attachments[file.blob.filename.to_s] = { mime_type: file.blob.content_type, content: file.blob.download }
          end
        mail(to: 'muffinmannnnnn@gmail.com', subject: "Crack Upload from #{@user.name}")

    end

    def reset_email
        @user = params[:user]
        mail(to: @user.email, subject: "AreaWide Password Reset")
    end

end
