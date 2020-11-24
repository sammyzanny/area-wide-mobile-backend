class UserMailer < ApplicationMailer
    default from: 'muffinmannnnnn@gmail.com'

    def upload_email
        @user = params[:user]
        @post = params[:post]
        mail(to: 'muffinmannnnnn@gmail.com', subject: "Crack Upload from #{@user.name}")
    end
end
