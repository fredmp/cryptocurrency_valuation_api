class UsersController < ApplicationController

  skip_before_action :authenticate!, only: [:create]

  def create
    if User.find_by(email: params[:email])
      render json: { message: "This email is already in use" }, status: :bad_request
      return
    end

    user = User.new(user_params)
    if user.save
      set_current_user(user)
      render json: user, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def update
    unless user
      render json: { message: "User does not exist" }, status: :bad_request
      return
    end

    if params[:password] && !user.authenticate(params[:current_password])
      render json: { message: 'Invalid password' }, status: :unauthorized
      return
    end

    user.name = user_params[:name] if user_params[:name]
    user.email = user_params[:email] if user_params[:email]
    user.local_currency = user_params[:local_currency] if user_params[:local_currency]
    user.password = params[:password] if params[:password]

    if user.save
      render json: user, status: :ok
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private

  def user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :local_currency)
  end
end
