class UsersController < ApplicationController
  skip_before_action :authorized, only: [:create, :index, :visit]

  def profile
    render json: { user: UserSerializer.new(current_user) }, status: :accepted
  end

  def update
    user = current_user
    user.update_attributes(user_params)
    if user.valid?
      render json: user
    else 
      render json: {error: "Profile update did not go through"}
    end
  
  end

  def visit
    user = User.find_by(username: params[:username])
    if user 
      render json: { user: UserSerializer.new(user) }, status: :accepted
    else
      render json: { error: 'User not found' }, status: :not_acceptable
    end

  end

  def index
    users = User.all
    render json: users
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      @token = encode_token(user_id: @user.id)
      render json: { user: UserSerializer.new(@user), jwt: @token }, status: :created
    else
      render json: { error: 'Failed to create user' }, status: :not_acceptable
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :name, :address, :phone, :officename)
  end

end
