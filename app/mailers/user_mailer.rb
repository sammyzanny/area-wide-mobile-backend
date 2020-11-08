class UserMailer < ApplicationMailer
    default from: 'crackupload@areawide.com'

    def upload_email
        @user = params[:user]
        @message = params[:post].message
        @images = params[:post].images

        mail(to: 'muffinmannnnnn@gmail.com', subject: "Crack Upload from #{@user[:name]}")
    end
end
