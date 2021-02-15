class PasswordsController < ApplicationController
    skip_before_action :authorized
  
    def forgot
        if params[:email].blank? # check if email is present
          return render json: {message: 'Email not present'}
        end
    
        user = User.find_by(email: params[:email]) # if present find user by email
    
        if user.present?
          user.generate_password_token! 
          UserMailer.with(user: user).reset_email.deliver_now
          render json: {message: "Reset email sent", status: 'ok'}, status: :ok
        else
          render json: {message: 'Email address not found. Please check and try again.'}, status: :not_found
        end
      end
    
      def reset
        token = params[:token].to_s
    
        if params[:email].blank?
          return render json: {message: 'Token not present'}
        end
    
        user = User.find_by(reset_password_token: token)
    
        if user.present? && user.password_token_valid?
          if user.reset_password!(params[:password])
            render json: {message: "Password changed successfully"}, status: :ok
          else
            render json: {message: user.errors.full_messages}, status: :unprocessable_entity
          end
        else
          render json: {message:  ['Link not valid or expired. Try generating a new link.']}, status: :not_found
        end
      end
  
   
  
  end
  